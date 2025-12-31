#--------------------------------
#
# Last modification : 2025.12.31
# Author            : Lasercata
# Version           : v1.0.1
#
#--------------------------------

# This script is called before running rofi (cf i3 config file) in order to have the variables set.
#
# It is also source by the bashrc.

#------Integrate KDE apps in i3
export QT_QPA_PLATFORMTHEME="qt5ct"
# export QT_STYLE_OVERRIDE="Breeze Dark"

#------Gnome dark mode
export GTK_THEME=Adwaita:dark

#------SSH agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket   
