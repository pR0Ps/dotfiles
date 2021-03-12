macOS setup
===========

Run `./apply_os_settings.sh` then log out and back in. This will clear all the default apps out of
the dock and set some system preferences.

Set up SMB auto-mounts in /mnt
------------------------------
Set up the auto-mount config file
```bash
echo $'\n# Custom SMB mounts\n/mnt auto_smb' | sudo tee -a /etc/auto_master >/dev/null
sudo touch /etc/auto_smb
sudo chmod a-rwx,u+rw /etc/auto_smb
```

Add mounts to `/etc/auto_smb` in the following format:
Note that everything in `<>`'s needs to be URL-escaped (ie. `@` --> `%40`)
```
<name> -fstype=smbfs ://<user>@<server>/<share>
```

Run `sudo automount -vc` to apply changes


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
