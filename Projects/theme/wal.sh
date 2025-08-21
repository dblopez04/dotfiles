#!/bin/bash
img=$1

# generate colorscheme
wal -i $img

# reload hyprland
hyprctl reload

pkill waybar
waybar &
disown

# set wallpaper
sed -E -i "0,/^preload/ s|^preload *=.*|preload = ${img}|" "$HOME/.config/hypr/hyprpaper.conf"
sed -E -i "s|^wallpaper *= *,.*|wallpaper = ,${img}|" "$HOME/.config/hypr/hyprpaper.conf"
pkill hyprpaper
hyprpaper &
disown

# sed -i "2c\$wallpaper = ${img}" "$HOME/.config/hypr/hyprlock.conf"

# update gtk colors
oomox-cli ~/.cache/wal/colors-oomox

# update firefox colors
pywalfox update

# update spotify colors
cp $HOME/.cache/wal/colors-spicetify.ini $HOME/.config/spicetify/Themes/text/color.ini
spicetify apply

clear
echo " Wallpaper changed to $img"
echo " Terminal colors changed"
echo " Hyprland colors changed"
echo " Waybar colors changed"
# echo " Hyprlock wallpaper changed"
echo " GTK themed"
echo " Spotify themed"
echo " Discord themed"
wal --preview
