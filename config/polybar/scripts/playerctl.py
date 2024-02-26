#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#--------------------------------
#
# Author            : Lasercata
# Last modification : 2024.02.26
# Version           : v1.0.0
#
#--------------------------------

##-Imports
from os import popen

#TODO: use signals + polybar tail mode ?

##-Ini
# ext_lst = ['.mp3', '.wav', '.m4a', '.wma']

fg = '%{F#d4d7ff}'
fg_paused = '%{F#77ffffff}'

ul = '%{u#ff4500}'
end_ul = '%{u-}'

col = '%{F#ff4500}'

default_len = 56


##-Useful functions
def time_to_str(n):
    '''
    Return n in a nice format.

    - n : a duration, in seconds.
    '''

    # if type(n) == str:
    #     n = float(n)

    if n < 3600:
        s = n % 60
        m = n // 60

        return format(m, '02') + ':' + format(s, '02')

    else: #Do you have a song that last more than a day !?!?
        s = n % 60
        m = (n // 60) % 60
        h = n // 3600

        return format(h, '02') + ':' + format(m, '02') + ':' + format(s, '02')


##-Main
class Player:
    def __init__(self, player=None, max_len=default_len):
        '''
        Initiate the class Player

        - player  : the player to consider in this class (for example, 'cmus', or 'firefox'). If None, uses the first one ;
        - max_len : the maximum length allowed to print.
        '''
    
        self.player = player

        if player == None:
            self.player_arg = ''
        else:
            self.player_arg = f'-p {player}'

        self.max_len = max_len

    def _get_status(self):
        '''Call playerctl to get the status for the current player'''

        return popen(f'playerctl {self.player_arg} status').read().strip('\n')

    def _get_metadata(self, add_pos=True):
        '''
        Call playerctl to get metadata and return it.
        If add_pos is true, it will call it another time to get the position.
        '''

        mt = popen(f'playerctl {self.player_arg} metadata').read().strip('\n').split('\n')

        if add_pos:
            mt.append('position  ' + popen(f'playerctl {self.player_arg} position').read().strip('\n'))

        return mt

    def _get_pos_long(self):
        '''
        Returns the position and the duration in a string, at the format [position/duration]
        Not used in order to reduce the number of calls to playerctl.
        '''

        return popen(f"playerctl {self.player_arg} metadata --format '[{{duration(position)}}/{{duration(mpris:length)}}]'").read().strip('\n')

    def _mt_to_dct(self, mt):
        '''
        Parse the metadata and return a dict containing the corresponding informations.

        - mt : the metadata to parse.
        '''

        # Formatting each line in a better way
        for j, k in enumerate(mt):
            mt[j] = k.split(' ')
            # mt[j] = k.split('  ') #TODO: this does not work. I need to find a solution to separate in three columns (player name, field name, data).
            #TODO: Or I could try to get each field one by one ? And manage the popen error ? But this would make many calls to the playerctl.

            l = []
            l.append(mt[j][0]) # player name

            # Search for next not empty string
            i = 1
            while mt[j][i] == '':
                i += 1

            #Adding field name
            l.append(mt[j][i])

            # Search for next not empty string
            i += 1
            while i < len(mt[j]) and mt[j][i] == '':
                i += 1

            # Adding data
            l.append(''.join(mt[j][i:]))

            mt[j] = l

        # Getting the player used
        d = {}
        d['player'] = mt[0][0] # note : this should be the same as self.player.

        for k in mt:
            if d['player'] in k:
                k.remove(d['player'])

            if '' in k:
                k.remove('')

        # print(mt) #TODO: remove

        # Getter remaining metadata
        for k in mt:
            for m in ('mpris:length', 'xesam:artist', 'xesam:title', 'position'):
                if m in k:
                    d[m.split(':')[-1]] = k[-1]

        for k in ('position', 'length'):
            if k in d.keys():
                d[k] = float(d[k])
                d[k] = int(d[k])

        if 'length' in d.keys():
            d['length'] = int(d['length'] / 10**6)

        # print(d) #TODO: remove
        return d

    def _get_long_pos_from_d(self, d):
        '''
        Return a string showing the position in the format [pos/duration].

        - d : the dict containing the informations.
        '''

        #TODO: remove
        # print('pos : {}, formatted : {}'.format(d['position'], time_to_str(d["position"])))
        # print('len : {}, formatted : {}'.format(d['length'], time_to_str(d["length"])))

        return f'[{time_to_str(d["position"])}/{time_to_str(d["length"])}]'

    def _get_short_pos_from_d(self, d):
        '''
        Return the percentage of the position in the song.

        - d : the dict containing the informations.
        '''

        return str(round(100 * d['position'] / d['length'])) + '%'

    def __str__(self):
        '''
        Get status and meta data and return accordingly a string.

        All the colors (background, foreground, underline), and the action when clicked are encoded in the string.

        - max_len : the max length of the string to return.
        '''

        status = self._get_status()
        mt_d = self._mt_to_dct(self._get_metadata())

        if status.lower() == 'stopped':
            return ''

        #------Making the full string
        #---Track
        if 'artist' in mt_d.keys() and mt_d['artist'] != '' and 'title' in mt_d.keys():
            track_str = mt_d['artist'] + ' - ' + mt_d['title']

        elif 'title' in mt_d.keys():
            track_str = mt_d['title']

        elif mt_d['player'] == 'cmus':
            track_str = get_cmus_trackname()

        else:
            track_str = 'unknown'

        #---Icon
        play_icon = ('󰏤', '󰐊')[status.lower() == 'playing']

        #---Position
        pos_str = self._get_long_pos_from_d(mt_d)
        percent_str = self._get_short_pos_from_d(mt_d)

        #---Calculate the optimal length
        partial_len = len(play_icon + ' ' + ' ' + pos_str)
        partial_len2 = len(play_icon + ' ' + ' ' + percent_str)

        # The beginning of the string (color for the icon, icon, color for the text.)
        playing_str = col + play_icon + (fg_paused, fg)[status.lower() == 'playing']

        # To toggle play / pause when left clicking on the text, add those around the text :
        bt_beg = '%{A1:' + self._play_pause_str() + ':}'
        bt_end = '%{A}'

        if len(track_str) + partial_len <= max_len:
            return bt_beg + ul + playing_str + ' ' + track_str + ' ' + pos_str + end_ul + bt_end

        elif len(track_str) + partial_len2 <= max_len:
            return bt_beg + ul + playing_str + ' ' + track_str + ' ' + percent_str + end_ul + bt_end

        else:
            l = max_len - partial_len2 - 3
            return bt_beg + ul + playing_str + ' ' + track_str[:l] + '... ' + percent_str + end_ul + bt_end


    def play(self):
        '''Put the current player in `play` mode.'''
    
        popen(f'playerctl {self.player_arg} play')

    def pause(self):
        '''Put the current player in `pause` mode.'''
    
        popen(f'playerctl {self.player_arg} pause')

    def play_pause(self):
        '''Toggle the current player between `play` and `pause` modes.'''
    
        popen(f'playerctl {self.player_arg} play-pause')

    def _play_pause_str(self):
        '''Returns the string representing the command to toggle play / pause the current player.'''
    
        return f'playerctl {self.player_arg} play-pause'

    def stop(self):
        '''Stops the current player.'''
    
        popen(f'playerctl {self.player_arg} stop')

    def previous(self):
        '''Command the player to go to the previous track'''
    
        popen(f'playerctl {self.player_arg} previous')

    def next(self):
        '''Command the current player to go to the next track'''
    
        popen(f'playerctl {self.player_arg} next')

    def seek(self, offset=5):
        '''
        Seek forwards if `offset` is positive, and backwards otherwise.

        - offset : the offset to seek, in seconds.
        '''

        if offset == 0:
            return

        elif offset < 0:
            popen(f'playerctl {self.player_arg} position {abs(offset)}-')

        else:
            popen(f'playerctl {self.player_arg} position {abs(offset)}+')


def get_cmus_trackname():
    '''Returns the trackname for the cmus player.'''

    return popen(r'''
        cmus-remote -Q |
            grep file |
            awk -F "/" '{print $NF}' |
            sed "s/\[.*\]\....//"
    ''').read().strip('\n')


def list_players():
    '''Return the list of all available players'''

    l = popen('playerctl -l').read().strip('\n').split('\n')

    # Always put cmus first
    if 'cmus' in l:
        l.remove('cmus')
        l = ['cmus'] + l

    return l


def print_all_players(max_len, remove_cmus=True):
    '''
    Print all the players' info.

    - remove_cmus : if true, ignore cmus.
    '''

    l = list_players()

    if remove_cmus and 'cmus' in l:
        l.remove('cmus')

    players = [Player(k, max_len=max_len) for k in l]

    for k in players:
        print(k, end=' | ')

    print('\b\b  \b\b')


##-Run
if __name__ == '__main__':
    from sys import argv

    if len(argv) == 1:
        max_len = default_len

    else:
        try:
            max_len = int(argv[1])

        except ValueError:
            max_len = default_len

    # Printing all players
    print_all_players(max_len, remove_cmus=False)
    # print_all_players(max_len, remove_cmus=True)
