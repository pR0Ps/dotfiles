macOS setup
===========

Run `./apply_os_settings.sh` then log out and back in. This will clear all the default apps out of
the dock and set some system preferences.


Misc other tweaks
-----------------
Don't block while checking the certificate revocation list before launching an application:
(will fully disable revocation checking - it's probably fine...)
```bash
if ! grep -q "127\.0\.0\.1.*ocsp.apple.com" /etc/hosts; then
    echo "127.0.0.1 ocsp.apple.com" | sudo tee -a /etc/hosts >/dev/null
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
fi
```

Disable Gatekeeper. Allows unsigned applications to be run without having to manually approve them.
```bash
sudo spctl --master-disable
```

Turn off System Integrity Protection (SIP):
1. Boot into recovery mode by holding CMD+R while booting
2. Launch Utilities -> Terminal
3. Run `csrutil disable`
4. Run `reboot`
