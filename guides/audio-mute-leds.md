## Audio Mute LEDs

The `HP Spectre x360 2-in-1 Laptop 16-aa0097nr` has two audio mute LED indicators:
* The speaker mute LED on key F6
* The microphone mute LED on key F9

Both of those LEDs should turn on when their respective device is muted. This works perfectly on Windows, but unfortunately does not work on Linux because of missing kernel patches that may never make it to mainline kernels. Nevertheless, the LEDs are recognized by Linux, but not configured properly.

This solution fixes this without patching and recompiling any kernel modules, for the sake of simplicity. It works by setting up a `systemd` service that subscribes to PulseAudio events to then update the LED status every time specific events are triggered.

### Pre-fix Test

Before proceeding with the fix, it is important that you test the actual commands used to turn those LEDs on and off, to make sure they work on your machine. Read [this guide](https://github.com/jcausse/spectre-fedora/blob/main/guides/audio-mute-leds-test-commands.md) to perform those tests, and then return here.

* If those worked, you can continue.
* Else, then I am afraid I can't help you any further until you figure out the exact commands. After you do, the scripts I made can still be used to fix this on your machine, given that you modify [this script](https://github.com/jcausse/spectre-fedora/blob/main/resources/audio-led/audio-led-sync.sh) to match the exact commands that worked for you.

### Fix

Run the following command (copy it and paste it in your terminal as a single line):

```bash
wget https://raw.githubusercontent.com/jcausse/spectre-fedora/main/resources/audio-led/audio-led.tar.gz && \
tar -xzf audio-led.tar.gz && mv ./audio-led/* . && \
sudo chmod +x audio-led-sync.sh && ./audio-led-sync.sh && rm -rf ./audio-led*
```
