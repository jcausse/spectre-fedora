#!/bin/bash

set -e

TARGET_SCRIPT_NAME="audio-led-sync.sh"
TARGET_SERVICE_NAME="audio-led-sync.service"

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

mv ./$TARGET_SCRIPT_NAME /usr/local/bin/$TARGET_SCRIPT_NAME
chmod +x /usr/local/bin/$TARGET_SCRIPT_NAME

mv ./$TARGET_SERVICE_NAME /etc/systemd/system/$TARGET_SERVICE_NAME
restorecon -v /etc/systemd/system/$TARGET_SERVICE_NAME

systemctl daemon-reload
systemctl enable --now $TARGET_SERVICE_NAME

echo "Installation complete! Service status:"

systemctl status $TARGET_SERVICE_NAME --no-pager
