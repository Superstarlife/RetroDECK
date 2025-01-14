#!/bin/bash

if [ -d ~/retrodeck/roms ] && [ -d /run/media/mmcblk0p1/retrodeck/roms ]
then # found both internal and sd folders
    zenity --title "RetroDECK" --warning --no-wrap --window-icon="/app/share/icons/hicolor/scalable/apps/net.retrodeck.retrodeck.svg" --text="I found a roms folder both in internal and SD Card,\nin order to make this tool useful you should remove one of the two or merge them."
    exit 0
fi

if [ -d ~/retrodeck/roms ] && [ ! -d /run/media/mmcblk0p1/retrodeck/roms ] 
then # found internal folder and not the external
    roms_path=~/retrodeck
    new_roms_path=/run/media/mmcblk0p1/retrodeck
fi

if [ ! -d ~/retrodeck/roms ] && [ -d /run/media/mmcblk0p1/retrodeck/roms ] 
then # found external folder and not the internal
    roms_path=/run/media/mmcblk0p1/retrodeck
    new_roms_path=~/retrodeck
fi

zenity --title "RetroDECK" --question --no-wrap --window-icon="/app/share/icons/hicolor/scalable/apps/net.retrodeck.retrodeck.svg" --text="Should I move the roms from\n\n$roms_path/roms\n\nto\n\n$new_roms_path/roms?"
if [ $? == 0 ] #yes
then
    mkdir -p $new_roms_path
    mv -f $roms_path/roms $new_roms_path/roms
    rm -f /var/config/emulationstation/ROMs
    ln -s $new_roms_path/roms /var/config/emulationstation/ROMs
    rm -f $roms_path/roms
fi
