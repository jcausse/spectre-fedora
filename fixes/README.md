# Fixes

* [WiFi D3Cold disable](#wifi-d3cold-disable)
* [Touchpad Palm Rejection](#palm-rejection)

## WiFi D3Cold disable

The HP Spectre x360 16-aa0097nr includes an Intel WiFi card, as you can see using `lspci`:

`01:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be) AX1775*/AX1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)`

When puting the laptop to sleep, the WiFi card enters a state where the Kernel is not able to wake it up again after exiting suspend mode. This state (D3Cold) needs to be disabled for the WiFi card to work properly. We use D3hot instead. To disable D3cold every time the WiFi card is initialized, run the following command. It will download the [fix script](https://raw.githubusercontent.com/jcausse/spectre-fedora/main/fixes/wifi-d3cold-fix.sh), make it executable, run it, and then delete it.

```bash
wget https://raw.githubusercontent.com/jcausse/spectre-fedora/main/fixes/wifi-d3cold-fix.sh -O wifi-d3cold-fix.sh && \
sudo chmod +x wifi-d3cold-fix.sh && \
./wifi-d3cold-fix.sh && \
rm wifi-d3cold-fix.sh
```

## Palm Rejection

Thanks to `aigilea` (see [this repo](https://github.com/aigilea/hp_spectre_x360_14_eu0xxx)).

Run the following command (copy and paste it in your terminal as if it was a single line). It will download the service file, copy it to the systemd directory, enable and start it, and finally remove the downloaded file.

```bash
wget https://raw.githubusercontent.com/jcausse/spectre-fedora/main/fixes/palm-rejection.service -O palm-rejection.service && \
sudo cp palm-rejection.service /etc/systemd/system/ && \
sudo systemctl enable palm-rejection.service && \
sudo systemctl start palm-rejection.service && \
sudo systemctl daemon-reload && \
rm palm-rejection.service && \
systemctl status palm-rejection.service
```

On success, you should see something like:

```
● palm-rejection.service - Enable Palm Rejection
     Loaded: loaded (/etc/systemd/system/palm-rejection.service; enabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/service.d
             └─10-timeout-abort.conf
     Active: active (exited) since Thu 2026-02-26 13:02:56 -03; 294ms ago
 Invocation: 5f29046fb7ee416c97d56c9ab3adec8b
   Main PID: 52544 (code=exited, status=0/SUCCESS)
   Mem peak: 2.7M
        CPU: 40ms

Feb 26 13:02:55 spectre systemd[1]: Starting palm-rejection.service - Enable Palm Rejection...
Feb 26 13:02:56 spectre sh[52546]: 4160
Feb 26 13:02:56 spectre systemd[1]: Finished palm-rejection.service - Enable Palm Rejection.
```
