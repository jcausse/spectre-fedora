# Audio Mute LEDs Test Commands

Before running the install script, run these commands to check that this solution will work for you:

1. Install dependencies:
    ```bash
    sudo dnf install -y alsa-utils alsa-tools
    ```

2. This command should turn the Speaker Mute LED on key F6 ON:
    ```bash
    sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x08
    ```

3. This command should turn the Speaker Mute LED on key F6 OFF:
    ```bash
    sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x00
    ```

4. This command should turn the Mic Mute LED on key F9 ON:
    ```bash
    sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x04 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x04 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00
    ```

5. This command should turn the Mic Mute LED on key F9 OFF:
    ```bash
    sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x04 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x04 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04
    ```

If these commands work for you, proceed with the installation.
