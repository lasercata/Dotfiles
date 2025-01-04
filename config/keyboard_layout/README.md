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

For more details on the use without sudo, see [this](https://askubuntu.com/questions/875163/is-it-possible-to-use-a-custom-keyboard-layout-without-sudo-access-if-so-how) and [that](https://askubuntu.com/questions/876005/what-file-is-the-setxkbmap-option-rules-meant-to-take-and-how-can-i-add-keyboa/896297#896297) questions.


## Configuration location
The file `fc` (which stands for *french custom*) should be located at `/usr/share/X11/xkb/symbols/fc` (for a global installation).

## Setup
### With sudo
It is advised to create a symbolic link :
```
sudo ln -s /absolute/path/to/config/keyboard_layout/fc /usr/share/X11/xkb/symbols/fc
```

Then to set this layout, run
```
setxkbmap fc
```

To make it permanent, change the `XKBLAYOUT` field in the [`config/xorg/00-keyboard.conf`](../xorg/00-keyboard.conf) file to `fc` (instead of `fr`).

### Without sudo (for one user)
Add the folder `xkb` to your home config folder :
```
ln -s full/path/to/dotfiles/config/keyboard_layout/xkb/ ~/.config/xkb
```

And then to use the layout, run
```
setxkbmap -I ~/.config/xkb/ fc
```

## Files
- `fc` : the definition of my custom layout.
