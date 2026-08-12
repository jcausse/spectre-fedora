#!/bin/bash
set -e

TARGET_SCRIPT_NAME="audio-led-sync.sh"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo ./audio-led-sync-install.sh)"
  exit 1
fi

#######################################################
# DEPENDENCIES:                                       #
# * pulseaudio-utils is needed for pactl              #
# * wireplumber and pipewire are needed for  wpctl    #
# * alsa-utils and alsa-tools are needed for hda-verb #
#######################################################

dnf install -y pulseaudio-utils alsa-utils alsa-tools wireplumber pipewire

mv ./audio-led-sync.sh /usr/local/bin/$TARGET_SCRIPT_NAME
chmod +x /usr/local/bin/$TARGET_SCRIPT_NAME
