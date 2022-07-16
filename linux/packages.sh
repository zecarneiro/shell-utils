#!/bin/bash

function InstallFlatpak {
    if ! CommandExist "flatpak"; then
        PrintMessage -m "\nInstall Flatpak"
        Eval "sudo apt install gnome-software gnome-software-plugin-flatpak xdg-desktop-portal-gtk flatpak -y"
    fi
}

function InstallSnap {
    if ! CommandExist "snap"; then
        PrintMessage -m "\nInstall Snap"
        Eval "sudo apt install snapd-xdg-open snapd -y"
    fi
}

function InstallDEBs {
    if ! CommandExist "gdebi"; then
        PrintMessage -m "\nInstall Gdebi"
        Eval "sudo apt install gdebi -y"
    fi
    # Info Link: https://github.com/wimpysworld/deb-get
    if ! CommandExist "deb-get"; then
        PrintMessage -m "\nInstall Deb-Get"
        if ! CommandExist "curl"; then
            Eval "sudo apt install curl -y"
        fi
        Eval "curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get"
    fi
}

function InstallAlien {
    # Info: RPM Installer
    if ! CommandExist "alien"; then
        PrintMessage -m "\nInstall Alien"
        Eval "sudo apt install alien -y"
    fi
}
