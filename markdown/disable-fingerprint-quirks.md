# Disable quirks

`sudo grubby --update-kernel=ALL --args="usbcore.quirks=06cb:00f9:k"`

# Revert changes

`sudo grubby --update-kernel=ALL --remove-args="usbcore.quirks=06cb:00f9:k"`

---

if this still doesn't work, we can tell the kernel to reset the device instead of trying to resume it:

`sudo grubby --update-kernel=ALL --remove-args="usbcore.quirks=06cb:00f9:k"`
`sudo grubby --update-kernel=ALL --args="usbcore.quirks=06cb:00f9:b"`