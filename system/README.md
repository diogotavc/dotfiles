# System

Files here should NOT be stowed, but copied and to the locations after `(...)/system/` and configured manually thereafter.

## /etc/udev/rules.d/99-fingerprint-autosuspend.rules

Run `sudo udevadm control --reload-rules` and `sudo udevadm trigger` after copying the file. Yet to confirm that it works.