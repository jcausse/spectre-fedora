#!/bin/bash

# ==============================================================================
# HP Spectre Audio Mute LED Sync Script (Root Level)
# Syncs physical F6 (Speaker Mute) and F9 (Mic Mute) LEDs via hda-verb
# ==============================================================================

# HDA Commands for Realtek ALC245 (/dev/snd/hwC1D0)
SPEAKER_ON="hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && hda-verb /dev/snd/hwC1D0 0x20 0x400 0x08"
SPEAKER_OFF="hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && hda-verb /dev/snd/hwC1D0 0x20 0x400 0x00"

MIC_ON="hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x04 && hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x04 && hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00"
MIC_OFF="hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x04 && hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x04 && hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04"

# Functions to update LED hardware states
update_speaker_led() {
    if wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "MUTED"; then
        eval "$SPEAKER_ON" >/dev/null 2>&1
    else
        eval "$SPEAKER_OFF" >/dev/null 2>&1
    fi
}

update_mic_led() {
    if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | grep -q "MUTED"; then
        eval "$MIC_ON" >/dev/null 2>&1
    else
        eval "$MIC_OFF" >/dev/null 2>&1
    fi
}

# Initial state check
update_speaker_led
update_mic_led

# Continuous monitoring via pactl subscribe
pactl subscribe 2>/dev/null | while read -r event; do
    if echo "$event" | grep -E -q "sink|source"; then
        update_speaker_led
        update_mic_led
    fi
done
