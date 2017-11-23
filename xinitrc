setxkbmap -layout "us,ru"
setxkbmap -option "grp:shift_alt_toggle,grp_led:scroll"

xsetroot -cursor_name left_ptr &

export PATH=~/bin:$PATH

feh --bg-fill ~/dotfiles/pictures/wallpapers/4.jpg

exec dbus-launch xmonad
