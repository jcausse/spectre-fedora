#!/bin/bash

echo "+-----------------------------------+"
echo "| 🛠 Applying fix for WiFi d3cold 🛠  |"
echo "+-----------------------------------+"

# 1. Find the PCI id of the WiFi card
NETWORK_CARD_PCI_ID=$(echo "0000:$(lspci | grep -i "network controller" | awk -F' ' '{print $1}')")
echo "> Detected WiFi card PCI ID: $NETWORK_CARD_PCI_ID"

# 2. Create a udev rule to disable D3Cold for the WiFi card
RULE_FILENAME="/etc/udev/rules.d/99-wifi-d3cold-disable.rules"
echo "> Creating udev rule to disable D3Cold for WiFi card. The applied udev rule is:"
echo "ACTION==\"add|bind\", SUBSYSTEM==\"pci\", KERNEL==\"$NETWORK_CARD_PCI_ID\", ATTR{d3cold_allowed}=\"0\"" | sudo tee $RULE_FILENAME > /dev/null

# 3. Reload and trigger udev rules
echo "> Reloading udev rules"
sudo udevadm control --reload-rules
sudo udevadm trigger --action=add --sysname-match="$NETWORK_CARD_PCI_ID"
sudo udevadm settle

# 4. Verify that D3Cold is disabled. It should return 0.
echo "> Verifying D3Cold is disabled"
RETURNED_VALUE=$(sudo cat /sys/bus/pci/devices/$NETWORK_CARD_PCI_ID/d3cold_allowed)


if [ "$RETURNED_VALUE" -eq 0 ]; then
    echo "✅ Successfully applied the fix!"
    echo "➡️  The created udev rule is located at $RULE_FILENAME"
else
    sudo rm $RULE_FILENAME
    echo "❌  Failed to apply the fix!"
    echo "➡️  No udev rule was created."
fi
