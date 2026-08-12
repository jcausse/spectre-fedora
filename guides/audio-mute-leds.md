## Audio Mute LEDs

The `HP Spectre x360 2-in-1 Laptop 16-aa0097nr` has two audio mute LED indicators:
* The speaker mute LED on key F6
* The microphone mute LED on key F9

Both of those LEDs should turn on when their respective device is muted. This works perfectly on Windows, but unfortunately does not work on Linux because of missing kernel patches that may never make it to mainline kernels. Nevertheless, the LEDs are recognized by Linux, but not configured properly.

This solution fixes this without patching and recompiling any kernel modules, for the sake of simplicity. It works by setting up a `systemd` service that subscribes to PulseAudio events to then update the LED status every time specific events are triggered.


https://github.com/jcausse/spectre-fedora/blob/main/resources/audio-led/test-commands.md