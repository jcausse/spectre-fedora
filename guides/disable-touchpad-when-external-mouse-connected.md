## Disable Touchpad When Mouse Connected

GNOME does not include an option by default to disable the touchpad when an external USB mouse is connected. Luckily, this can be easily achieved by running this single command:

```bash
gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled-on-external-mouse
```
