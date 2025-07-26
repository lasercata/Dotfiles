#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#--------------------------------
#
# Author            : Lasercata
# Last modification : 2025.07.26
# Version           : v1.0.4
#
#--------------------------------

##-Imports
from os import popen
from subprocess import PIPE, Popen
import re

#TODO: use signals + polybar tail mode ?

##-Ini
fg = '%{F#d4d7ff}'
fg_paused = '%{F#77ffffff}'

ul = '%{u#ff4500}%{+u}'
# end_ul = '%{u-}'

accent_col = '%{F#ff4500}'
accent_col_2 = '%{F#91f5f3}' # cyan-3

DEFAULT_MAX_LEN = 56 # Default maximum length for the whole string (with all the players), ignoring the invisible characters.
DEFAULT_MIN_LEN_STR = 3 # Default minimum length for the title of a player (not including the position / duration nor the play/pause button).
DEFAULT_MIN_LEN = len('󰏤 ' + '~ [xx%|xxm]') + DEFAULT_MIN_LEN_STR # Minimum length for a player, including position / duration + play/pause button.


##-Useful functions
def time_to_str(n: int, lazy: bool = False) -> str:
    '''
    Return n in a nice format.

    - n: a duration, in seconds ;
    - lazy: if True, will round the output.
    '''

    if n == '?':
        return '?'

    if n < 3600:
        s = n % 60
        m = n // 60

        if lazy:
            if s > 30: # Round minutes
                m += 1

            if m > 0:
                return f'{m}m'

            else:
                return f'{s}s'

        return format(m, '02') + ':' + format(s, '02')

    else:
        s = n % 60
        m = (n // 60) % 60
        h = n // 3600

        if lazy:
            if m > 30: # Round hours
                h += 1

            return f'{h}h'

        return format(h, '02') + ':' + format(m, '02') + ':' + format(s, '02')


##-Main
class Player:
    def __init__(self, player=None, max_len=DEFAULT_MAX_LEN):
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

        self.max_len = int(max_len)

        self.status = None

    def set_max_len(self, max_len: float | int):
        '''Setter for `self.max_len`.'''
    
        self.max_len = int(max_len)

    def _get_status(self) -> str:
        '''
        Call playerctl to get the status for the current player.

        It stores the result in self.status, and returns this instead of calling playerctl if it has been set.
        '''

        if self.status == None:
            self.status = popen(f'playerctl {self.player_arg} status').read().strip('\n')

        return self.status

    def is_stopped(self) -> bool:
        '''Returns True if and only if the current player is stopped.'''
    
        return self._get_status().lower() == 'stopped'

    def is_playing(self) -> bool:
        '''Returns True if and only if the current player is playing.'''
    
        return self._get_status().lower() == 'playing'

    def is_paused(self) -> bool:
        '''Returns True if and only if the current player is paused.'''
    
        return self._get_status().lower() == 'paused'

    def _get_metadata(self, add_pos: bool = True) -> list[str]:
        '''
        Call playerctl to get metadata and return it.
        If add_pos is true, it will call it another time to get the position.
        '''

        mt = popen(f'playerctl {self.player_arg} metadata').read().strip('\n').split('\n')

        if add_pos:
            # pos = popen(f'playerctl {self.player_arg} position').read().strip('\n')
            pos, _ = Popen(f'playerctl {self.player_arg} position', shell=True, stdout=PIPE, stderr=PIPE).communicate()

            pos = pos.decode().strip('\n')

            if pos == '':
                pos = '?'

            mt.append('position  ' + pos)

        return mt

    def _get_pos_long(self) -> str:
        '''
        Returns the position and the duration in a string, at the format '[position/duration]'
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
            l.append(' '.join(mt[j][i:]))

            mt[j] = l

        # Getting the player used
        d = {}
        d['player'] = mt[0][0] # note : this should be the same as self.player.

        for k in mt:
            if d['player'] in k:
                k.remove(d['player'])

            if '' in k:
                k.remove('')

        # Getter remaining metadata
        for k in mt:
            for m in ('mpris:length', 'xesam:artist', 'xesam:title', 'position'):
                if m in k and len(k) > 1:
                    d[m.split(':')[-1]] = k[-1]

        for k in ('position', 'length'):
            if k in d.keys() and d[k] != '?':
                d[k] = float(d[k])
                d[k] = int(d[k])

        if 'length' in d.keys():
            d['length'] = int(d['length'] / 10**6)

        return d

    def _get_short_pos_from_d(self, d):
        '''
        Return the percentage of the position in the song.

        - d : the dict containing the informations.
        '''

        if d['position'] == '?' or 'length' not in d:
            return '?%'

        return str(round(100 * d['position'] / d['length'])) + '%'

    def _get_long_pos_from_d(self, d, with_color=True):
        '''
        Return a string showing the position in the format `[pos/duration] x%`.

        - d           : the dict containing the informations ;
        - with_colors : if True, also add colors.
        '''

        if d['position'] == '?' or 'length' not in d:
            return '[?/?]'

        percent = self._get_short_pos_from_d(d)

        if with_color:
            return accent_col_2 + f'{percent} ' + accent_col + '[' + accent_col_2 + time_to_str(d['position']) + accent_col + f'/{time_to_str(d["length"])}]'
            # return accent_col + '[' + accent_col_2 + time_to_str(d['position']) + accent_col + f'/' + accent_col_2 + time_to_str(d['length']) + accent_col + ']'

        return f'[{time_to_str(d["position"])}/{time_to_str(d["length"])}] {percent}'

    def _get_mixed_pos_from_d(self, d, with_color: bool = True, lazy: bool = False):
        '''
        Return a string showing the position in the format [pos%|duration].

        - d: the dict containing the informations ;
        - with_colors: if True, also add colors ;
        - lazy: if True, round the duration.
        '''

        if d['position'] == '?' or 'length' not in d:
            return '[?|?]'

        percent = self._get_short_pos_from_d(d)

        if with_color:
            return accent_col + '[' + accent_col_2 + percent + accent_col + f'|{time_to_str(d["length"], lazy)}]'

        return f'[{percent}|{time_to_str(d["length"], lazy)}]'

    def __str__(self) -> str:
        '''
        Get status and meta data and return accordingly a string.

        All the colors (background, foreground, underline), and the action when clicked are encoded in the string.

        - self.max_len : the max length of the string to return.
        '''

        status = self._get_status()

        if status.lower() == 'stopped':
            return ''

        mt_d = self._mt_to_dct(self._get_metadata())

        #------Making the full string
        #---Track
        if 'artist' in mt_d.keys() and mt_d['artist'] != '' and 'title' in mt_d.keys() and mt_d['artist'] not in mt_d['title'] and mt_d['artist'].replace(' ', '_') not in mt_d['title']:
            track_str = mt_d['artist'] + ' - ' + mt_d['title']

        elif 'title' in mt_d.keys():
            track_str = mt_d['title']

        elif mt_d['player'] == 'cmus':
            track_str = get_cmus_trackname()

        else:
            track_str = 'unknown'

        # Remove file extension and youtube id
        to_remove_expr = [re.compile(r'\[[a-zA-Z0-9_\-]{11}\]\....$'), re.compile(r'\[[a-zA-Z0-9_\-]{11}\]$'), re.compile(r'\(320 kbps\)\....$'), re.compile(r'\....$')]
        to_remove_str = [e.findall(track_str) for e in to_remove_expr]

        for o in to_remove_str:
            if len(o) > 0:
                track_str = track_str.replace(o[-1], '')

        track_str.strip(' ')

        #---Icon
        play_icon = ('󰏤', '󰐊')[status.lower() == 'playing']

        #---Position
        lazy_duration = self.is_paused()

        mixed_str = self._get_mixed_pos_from_d(mt_d, with_color=False, lazy=lazy_duration)
        mixed_str_col = self._get_mixed_pos_from_d(mt_d, with_color=True, lazy=lazy_duration)

        pos_str = self._get_long_pos_from_d(mt_d, with_color=False)
        pos_str_col = self._get_long_pos_from_d(mt_d, with_color=True)

        # percent_str = self._get_short_pos_from_d(mt_d)

        #---Calculate the optimal length
        partial_len = len(play_icon + ' ' + ' ' + pos_str)
        partial_len3 = len(play_icon + ' ' + ' ' + mixed_str)

        # The beginning of the string (color for the icon, icon, color for the text.)
        playing_str = accent_col + play_icon + (fg_paused, fg)[status.lower() == 'playing']

        # To toggle play / pause when left clicking on the text, add those around the text :
        bt_beg = '%{A1:' + self._play_pause_str() + ':}'
        bt_end = '%{A}'

        if len(track_str) + partial_len <= self.max_len:
            return bt_beg + ul + playing_str + ' ' + track_str + ' ' + pos_str_col + bt_end

        elif len(track_str) + partial_len3 <= self.max_len:
            # return bt_beg + ul + playing_str + ' ' + track_str + ' ' + accent_col + percent_str + bt_end
            return bt_beg + ul + playing_str + ' ' + track_str + ' ' + accent_col + mixed_str_col + bt_end

        else:
            l = max(self.max_len - partial_len3 - 1, DEFAULT_MIN_LEN_STR) # This may cause the widget to be a bit larger than allowed

            # return bt_beg + ul + playing_str + ' ' + track_str[:l] + '~ ' + accent_col + percent_str + bt_end
            return bt_beg + ul + playing_str + ' ' + track_str[:l] + '~ ' + accent_col + mixed_str_col + bt_end


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
            sed "s/\[[a-zA-Z0-9_\-]\]\....$//" |
            sed "s/\....$//"
    ''').read().strip('\n')


def list_players() -> list[str]:
    '''Return the list of all available players'''

    l, _ = Popen('playerctl -l', shell=True, stdout=PIPE, stderr=PIPE).communicate()

    if l == b'':
        return []

    l = l.decode().strip('\n').split('\n')

    # Always put cmus first
    if 'cmus' in l:
        l.remove('cmus')
        l = ['cmus'] + l

    return l


def print_all_players(max_len: int, remove_cmus: bool = True):
    '''
    Print all the players' info.

    - max_len: the maximum length for the printed string (only visible characters) ;
    - remove_cmus: if true, ignore cmus.
    '''

    #---List and create the players
    l = list_players()

    if remove_cmus and 'cmus' in l:
        l.remove('cmus')

    players = [Player(p) for p in l]

    #---Remove stopped players from the list + count players currently playing
    nb_playing = 0
    k = 0
    while k < len(players):
        if players[k].is_stopped():
            players.pop(k)

        else:
            # Count playing players
            if players[k].is_playing():
                nb_playing += 1

            k += 1

    #---If all players are stopped, do not show anything.
    if len(players) == 0:
        print()
        return

    #---Setting the length limit
    # Calculating the length for playing players
    # Long length: the length for the playing players.
    # Short length: the length for the paused players.

    short_len = DEFAULT_MIN_LEN

    if nb_playing == 0:
        long_len = max_len / len(players)
    else:
        long_len = int((max_len - short_len * (len(players) - nb_playing)) / nb_playing)

        if long_len < 0:
            long_len = max_len / len(players)
            short_len = long_len

    # Setting the lengths
    for p in players:
        if p.is_playing() or nb_playing == 0:
            p.set_max_len(long_len)
        
        else:
            p.set_max_len(short_len)

    #---Printing players' informations
    for k, p in enumerate(players):
        print(p, end='')

        if k != len(players) - 1: # Prints the separation between players
            print(' ' + accent_col_2 + '|%{F-} ', end='') #cyan-3

    print()


##-Run
if __name__ == '__main__':
    from sys import argv

    if len(argv) == 1:
        max_len = DEFAULT_MAX_LEN

    else:
        try:
            max_len = int(argv[1])

        except ValueError:
            max_len = DEFAULT_MAX_LEN

    # Printing all players
    print_all_players(max_len, remove_cmus=False)
