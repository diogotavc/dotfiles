#!/bin/bash

# Description: Resets Synaptics Fingerprint Reader on Resume
# Device: 06cb:00f9
# Reason: Fixes "endpoint stalled" error after s2idle

case "$1" in
    post)
        # Only run on wake (post)
        VID="06cb"
        PID="00f9"

        # Check if device exists
        if lsusb -d $VID:$PID > /dev/null; then
            logger "FP-RESET: Attempting to reset fingerprint reader..."

            # 1. Stop fprintd to release the device
            systemctl stop fprintd

            # 2. Find the Device Node (Bus and Device ID)
            # Returns format like: /dev/bus/usb/003/005
            DEV_NODE=$(lsusb -d $VID:$PID | awk -F '[ :]' '{printf "/dev/bus/usb/%s/%s", $2, $4}')

            if [ ! -z "$DEV_NODE" ]; then
                # 3. Perform the Reset (Magic number 21780 = USBDEVFS_RESET for x86_64)
                python3 -c "import fcntl, os; fd=os.open('$DEV_NODE', os.O_WRONLY); fcntl.ioctl(fd, 21780, 0); os.close(fd)" 2>/dev/null

                if [ $? -eq 0 ]; then
                    logger "FP-RESET: Device $DEV_NODE reset successfully."
                else
                    logger "FP-RESET: Python reset command failed."
                fi
            else
                logger "FP-RESET: Could not determine device node."
            fi

            # 4. Restart fprintd so it's ready for login
            systemctl start fprintd
            logger "FP-RESET: fprintd restarted."
        else
            logger "FP-RESET: Device not found (physically disconnected?)"
        fi
        ;;
esac
