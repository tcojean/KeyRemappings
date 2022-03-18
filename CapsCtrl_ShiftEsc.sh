#!/usr/bin/env bash

#########################
###### Setup check  #####
#########################
cmds=(xcape xmodmap setxkbmap)
has_all_cmd=1
for cmd in "${cmds[@]}"; do
    if ! command -v "${cmd}" &>/dev/null
    then
        has_all_cmd=0
    fi
done
if [ ${has_all_cmd} -eq 0 ]; then
    printf '%s are needed for this script\n' "${cmds[*]}"
    exit
fi

# ensure the layout is qwerty before calling the script
layout="$(setxkbmap -query | grep layout | tr -d ' ' | cut -d ":" -f 2)"
variant="$(setxkbmap -query | grep variant)"
if [[ "$layout" != "us" || ("$layout" == "us" && "$variant" != "") ]]; then
    printf "This script only works for the qwerty layout."
    printf "Adapt the script or switch to the us (qwerty) layout.\n"
fi

if pgrep xcape &>/dev/null; then
    killall xcape
fi


#########################
###### Key remaps   #####
#########################

## Use a spare modifier and xmodmap to put control on the caps lock key
spare_modifier="Hyper_R"
xmodmap -e "remove lock = Caps_Lock"
xmodmap -e "keycode 66 = $spare_modifier $spare_modifier $spare_modifier $spare_modifier"
xmodmap -e "add Control = $spare_modifier"

xmodmap -e "keycode any = Caps_Lock ISO_Next_Group Caps_Lock ISO_Next_Group"

# Finally use xcape to give back the caps lock capacity when pressed <= 256 ms
xcape -e "$spare_modifier=Caps_Lock" -t 256

## Do the same for keycode 48, '" on qwerty keyboards
spare_modifier="Hyper_L"
xmodmap -e "keycode 207 = NoSymbol NoSymbol NoSymbol NoSymbol"
xmodmap -e "keycode 48 = $spare_modifier $spare_modifier $spare_modifier $spare_modifier"
xmodmap -e "remove mod4 = $spare_modifier" #hyper_l is mod4 by default
xmodmap -e "add Control = $spare_modifier"

# Finally use xcape to give back the key capacity when pressed <= 256 ms
# TODO: This part needs to be adapted for different layouts
xmodmap -e "keycode any = apostrophe quotedbl"
xcape -e "$spare_modifier=apostrophe" -t 256

# Put Escape on both shifts
xcape -e "Shift_L=Escape;Shift_R=Escape"
