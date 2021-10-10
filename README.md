# ASCII Emoji Buckts
Emoji Buckets is a shell extension for the [GNOME](https://www.gnome.org/) desktop.

## About
This is a fork of  https://github.com/harshkhandeparkar/gnome-ascii-emoji-buckets



## Installation
These are UTF-8 symbols so it should work on almost every system without any extra fonts, yay!

* Install with Source from git
  ```
  $ git clone https://github.com/maisk/gnome-ascii-emoji-buckets.git  ~/.local/share/gnome-shell/extensions/ascii_buckets@maistrelis.com
  ```


Log out or restart the GNOME shell to make it available in GNOME Tweak. Note that on Wayland restarting the GNOME shell is not working as of 3.22.2.

## Troubleshooting

One of the best ways to troubleshoot is to watch the logs with `journalctl` and restart the extension. You can reload this extension with the handy [Gnome Shell Extension Reloader](https://extensions.gnome.org/extension/1137/gnome-shell-extension-reloader/) extension.

```
journalctl --since="`date '+%Y-%m-%d %H:%M'`" -f | grep ascii_buckets
```


