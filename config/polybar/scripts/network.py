#!/bin/python3

#--------------------------------
#
# Last modification : 2023.05.16
# Author            : Lasercata
# Version           : v1.0.2
#
#--------------------------------

##-Imports
from os import popen


##-Get infos
def get_str(interface='wlp3s0'):
    '''Return the string of informations.'''

    return popen(f'/usr/sbin/iwconfig {interface}').read().split('\n')


def is_wifi_on():
    return 'on' in popen('wifi').read()


def get_infos(status_str):
    '''get info from the above string'''

    d = {}
    d['power'] = is_wifi_on()

    if not d['power']:
        return d

    for k in status_str:
        if 'ESSID:' in k:
            d['ESSID'] = k[len('ESSID:') + k.index('ESSID:'):].strip(' ').strip('"')
            d['connected'] = d['ESSID'] != 'off/any'

        if 'Link Quality=' in k:
            s = k.strip(' ')[len('Link Quality='):]
            d['strength_str'] = s[:s.index(' ')]

            a, b = d['strength_str'].split('/')
            d['strength_current'] = int(a)
            d['strength_max'] = int(b)
            d['strength_percent'] = int(a) / int(b)

    return d

def pretty_string(d, max_len=16):
    '''Return wifi informations in a pretty string.'''

    if not d['power']:
        return '%{F#66ffffff}󰤭 '

    if not d['connected']:
        return '%{F#f6668a}%{u#f6668a}%{+u}󰤯 ' #red-3
    
    ramp = ['󰤯 ', '󰤟 ', '󰤢 ', '󰤥 ', '󰤨 ']
    logo = '%{F#7ff3ef}%{u#7ff3ef}%{+u}' + ramp[int((len(ramp) - 1) * d['strength_percent'])] #cyan-2
    name = d['ESSID']

    if len(name) > max_len:
        name = name[:max_len - 3] + '...'

    label = '%{F#d4d7ff}' + name #fg-1

    return logo + label


if __name__ == '__main__':
    print(pretty_string(get_infos(get_str())))
