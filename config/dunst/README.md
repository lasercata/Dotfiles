# Dunst
[Dunst](https://dunst-project.org) is a notification daemon.

Note : to reload after changing the `dunstrc` file, simply run
```
killall dunst
notify-send test
```
The service is automatically started again with DBus (the second command is not necessary).

## Configuration location
The configuration folder is located at `~/.config/dunst/`.

You might also need the file `org.freedesktop.Notifications.service`, located at `/usr/share/dbus-1/services/` to launch it.

## File
- `dunstrc` : the configuration file for dunst.
