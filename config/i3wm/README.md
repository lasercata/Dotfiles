# i3wm
[i3wm](https://i3wm.org/) is a customizable keyboard focused window manager.

For rounded corners, it is needed to download and build this fork : `https://github.com/jbenden/i3-gaps-rounded`
After building it, copy the `i3` executable to `/usr/bin/i3-gaps-rounded`.

## Configuration location
The configuration folder is located at `~/.config/i3/`.

To be able to launch i3 as your window manager, paste the `*.desktop` files to `/usr/share/xsessions`

## File
- `config` : the configuration file for i3wm.


## Key binds
Modifier : `mod` = meta (windows key).

### Windows and workspaces
| Action | Key bind |
| ------ | -------- |
| Change focus | `mod+[hjkl]` |
| Move focused container  | `mod+shift+[hjkl]` |
| Move focused container to workspace `n`  | `mod+shift+[n]` |
| Move workspace through outputs (screens) | `mod+ctrl+[hjkl]` |
| Change focus output-wise | `mod+alt+[hjkl]` |
| Move focused container output-wise | `mod+alt+shift+[hjkl]` |
| Focus floating toggle | `mod+space` |
| Focus parent container | `mod+a` |
| Focus child container | `mod+shift+a` |

### Layout
| Action | Key bind |
| ------ | -------- |
| Resize | `mod+ctrl+shift+[hjkl]` |
| Resize mode | `mod+r` |
| Split horizontal direction | `mod+g` |
| Split vertical direction | `mod+v` |
| Fullscreen | `mod+f` |
| Stacked layout | `mod+s` |
| Tabbed layout | `mod+w` |
| Split layout (toggle) | `mod+e` |
| Focus floating toggle | `mod+space` |
| Floating toggle | `mod+shift+space` |

### Apps
| Action | Key bind |
| ------ | -------- |
| Open app launcher | `mod+m` |
| Open terminal | `mod+enter` |
| Window finder | `mod+d` |

### Other
| Action | Key bind |
| ------ | -------- |
| Kill window | `mod+shift+q` |
| Reload config | `mod+shift+c` |
| Restart in place | `mod+shift+r` |
| Exit i3 | `mod+shift+e` |
| Play / pause media | `mod+p` |
| Toggle touchpad | `mod+u` |
| Lock | `mod+o` |
| Suspend (sleep) | `mod+shift+o` |
