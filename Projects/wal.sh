#!/bin/bash
img=$1

# generate colorscheme
wal -i $img

pkill waybar
waybar & disown

# set wallpaper
sed -E -i "0,/^preload/ s|^preload *=.*|preload = ${img}|" "$HOME/.config/hypr/hyprpaper.conf"
sed -E -i "s|^wallpaper *= *,.*|wallpaper = ,${img}|" "$HOME/.config/hypr/hyprpaper.conf"
pkill hyprpaper
hyprpaper &
disown

sed -i "2c\$wallpaper = ${img}" "$HOME/.config/hypr/hyprlock.conf"

# update gtk colors
cp -f $HOME/.cache/wal/colors-oomox $HOME/.config/oomox/colors
cd $HOME/oomox-gtk-theme/
./change_color.sh $HOME/.cache/wal/colors-oomox -o oomox-colors-oomox -t $HOME/.themes/

# update firefox colors
pywalfox update

# update spotify colors
cp $HOME/.cache/wal/colors-spicetify.ini $HOME/.config/spicetify/Themes/text/color.ini
spicetify apply

# update discord colors
cp $HOME/.cache/wal/colors-discord.css $HOME/.config/vesktop/themes/colors-discord.css

clear
echo " Wallpaper changed to $img"
echo " Terminal colors changed"
echo " Waybar colors changed"
echo " Hyprlock wallpaper changed"
echo " Dunst colors changed"
echo " GTK theme exported"
echo " Spotify themed"
echo " Discord themed"
wal --preview
