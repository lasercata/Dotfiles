#!/bin/python3

#--------------------------------
#
# Last modification : 2023.05.16
# Author            : Lasercata
# Version           : v1.1.2
#
#--------------------------------

##-Imports
from os import popen


##-Ini
ext_lst = ['.mp3', '.wav', '.m4a', '.wma']
fg = '%{F#d4d7ff}'
fg_paused = '%{F#77ffffff}'
col = '%{F#ff4500}'


##-Useful functions
def time_to_str(n):
    '''
    Return n in a nice format.

    - n : a duration, in seconds.
    '''

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
def get_status():
    return popen('cmus-remote -Q').read().split('\n')

def get_infos(status_str):
    '''Return a dict containing the informations of the status.'''

    d = {}
    for k in status_str:
        if k[:len('status')] == 'status':
            d['playing'] = 'playing' in k
            d['stopped'] = 'stopped' in k

        elif k[:len('file')] == 'file':
            d['path'] = k.strip('file ')
            d['fn'] = d['path'].split('/')[-1]

            #remove extension
            for e in ext_lst:
                if d['fn'][-len(e):] == e:
                    d['fn'] = d['fn'][:-len(e)]

        elif k[:len('tag')] == 'tag':
            s = k[len('tag '):]

            if s[:len('artist')] == 'artist':
                d['artist'] = s[len('artist '):]

            if s[:len('title')] == 'title':
                d['title'] = s[len('title '):]

        elif k[:len('duration')] == 'duration':
            d['duration'] = int(k[len('duration '):])

        elif k[:len('position')] == 'position':
            d['position'] = int(k[len('position '):])

    return d


def pretty_string(s_dct, max_len=56):
    '''Show a pretty string with the informations in s_dct, that do not exceed max_len in length.'''

    if s_dct['stopped']:
        return ''

    percent_str = str(round(100 * s_dct['position'] / s_dct['duration'])) + '%'

    pos_str = '[{}/{}]'.format(time_to_str(s_dct['position']), time_to_str(s_dct['duration']))

    if 'title' in s_dct.keys() and 'artist' in s_dct.keys():
        track_str = s_dct['artist'] + ' - ' + s_dct['title']

    else:
        track_str = s_dct['fn']

    playing_str = ('󰏤', '󰐊')[s_dct['playing']]

    partial_len = len(playing_str + ' ' + ' ' + pos_str)
    partial_len2 = len(playing_str + ' ' + ' ' + percent_str)

    playing_str = col + playing_str + (fg_paused, fg)[s_dct['playing']]

    if len(track_str) + partial_len <= max_len:
        return playing_str + ' ' + track_str + ' ' + pos_str

    elif len(track_str) + partial_len2 <= max_len:
        return playing_str + ' ' + track_str + ' ' + percent_str

    else:
        l = max_len - partial_len2 - 3
        return playing_str + ' ' + track_str[:l] + '... ' + percent_str


##-Run
if __name__ == '__main__':
    print(pretty_string(get_infos(get_status())))

