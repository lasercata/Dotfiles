# Keyboard layout

This is the configuration for my custom keyboard layout.

My custom layout is basically the fr (french) azerty layout, but with the keys `wxcvb` shifted to the left (`<` becomes `w`, ..., `b` becomes `<`).

Here is a representation of the layout :
```
 ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ _______
|    | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 0  | °  | +  | <--   |
| ²  | &  | é ~| " #| ' {| ( [| - || è `| _ \| ç ^| à @| ) ]| = }|       |
 ========================================================================
| |<-  | A  | Z  | E  | R  | T  | Y  | U  | I  | O  | P  | ¨  | $  |   , |
|  ->| | a  | z  | e €| r  | t  | y  | u  | i  | o  | p  | ^  | £ ¤| <-' |
 ===================================================================¬    |
|       | Q  | S  | D  | F  | G  | H  | J  | K  | L  | M  | %  | µ  |    |
| ESC   | q  | s  | d  | f  | g  | h  | j  | k  | l  | m  | ù  | *  |    |
 ========================================================================
| ^   | W  | X  | C  | V  | B  | >  | N  | ?  | .  | /  | §  |     ^     |
| |   | w  | x  | c  | v  | b  | <  | n  | ,  | ;  | :  | !  |     |     |
 ========================================================================
|      |      |      |                       |       |      |     |      |
| Ctrl | Super| Alt  | Space    Nobreakspace | AltGr | Super|Menu | Ctrl |
 ¯¯¯¯¯¯ ¯¯¯¯¯¯ ¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯ ¯¯¯¯¯¯ ¯¯¯¯¯ ¯¯¯¯¯¯
```

For more information, read [this unix stackexchange answer](https://unix.stackexchange.com/a/709459).

## Configuration location
The file `fc` should be located at `/usr/share/X11/xkb/symbols/fc`.

## Setup
It is advised to create a symbolic link :
```
sudo ln -s /absolute/path/to/config/keyboard_layout/fc /usr/share/X11/xkb/symbols/fc
```

Then to set this layout, run
```
setxkbmap fc
```

## Files
- `fc` : the definition of my custom layout.
