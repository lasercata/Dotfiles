#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#--------------------------------
#
# Author            : Lasercata
# Last modification : 2025.08.28
# Version           : v1.0.0
#
#--------------------------------

##-Imports
from kitty.boss import Boss
from kittens.tui.handler import result_handler
import kitty.fast_data_types as f

# import subprocess

##-Main
def main(args: list[str]) -> str:
    pass

##-Toggle
@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    os_window_id = f.current_focused_os_window_id()
    current_opacity = f.background_opacity_of(os_window_id)

    opaque = '1.0'
    # a = 'default' if str(current_opacity) == opaque else opaque
    # subprocess.run(['notify-send', 'debug', 'current opacity: ' + str(current_opacity) + '\nchoosen opacity: ' + a])

    boss.set_background_opacity('default' if str(current_opacity) == opaque else opaque)

