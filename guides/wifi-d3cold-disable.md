## WiFi D3Cold disable

The HP Spectre x360 16-aa0097nr includes an Intel WiFi card, as you can see using `lspci`:

`01:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be) AX1775*/AX1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)`

When puting the laptop to sleep, the WiFi card enters a state where the Kernel is not able to wake it up again after exiting suspend mode. This state (D3Cold) needs to be disabled for the WiFi card to work properly. We use D3hot instead. To disable D3cold every time the WiFi card is initialized, run the following command. It will download the [fix script](https://raw.githubusercontent.com/jcausse/spectre-fedora/main/resources/wifi-d3cold-fix.sh), make it executable, run it, and then delete it.

```bash
wget https://raw.githubusercontent.com/jcausse/spectre-fedora/main/resources/wifi-d3cold-fix.sh && \
sudo chmod +x wifi-d3cold-fix.sh && ./wifi-d3cold-fix.sh && rm wifi-d3cold-fix.sh
```
