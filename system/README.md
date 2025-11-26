# System

Files here should NOT be stowed, but copied and to the locations after `(...)/system/` and configured manually thereafter.

# /lib/systemd/system-sleep/fingerprint-reset.sh

## don't think this works, may be related to selinux and i can't be bothered to look into it :)

This script tries to mitigate the fingerprint issue (06cb:00f9, ThinkPad P14s Gen 6 w/AMD Ryzen AI 9 HX PRO 370) where it randomly goes into a "zombie" mode after sleep.
Copy it to the correct path and make sure it's executable. To verify its behaviour, run `journalctl -t FP-RESET`.
