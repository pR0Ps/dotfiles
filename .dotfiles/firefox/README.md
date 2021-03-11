Firefox configuration
=====================

Setup
-----
```bash
cd <firefox directory>/Profiles/<your profile>/

# The following will link the files making it easier to update them
# Replacing 'ln' with 'cp' will also work
ln -s ~/.dotfiles/firefox/user.js .
mkdir -p chrome
ln -s ~/.dotfiles/firefox/userChrome.css chrome/

# Disable collecting HSTS sites (replaced by enabling https-only mode)
: > SiteSecurityServiceState.txt
chmod a-w SiteSecurityServiceState.txt

# Log into Firefox Account to sync extensions and other data
```

user.js
-------
Sets a bunch of `about:config` options. Read the file for the specifics.

userChrome.css
--------------
Hides the tabs on the top of the window (replaced with an addon that puts tabs on the side)

Extensions
----------
Not a complete list. In the event that I can't automatically sync extensions using a Firefox Account
these are the essential extensions I would manually install.

| Name | Details |
|------|---------|
| [cliget](https://addons.mozilla.org/firefox/addon/cliget) | Generates `curl`/`wget`/`aria2` commands for downloading files |
| [Sidebery](https://addons.mozilla.org/firefox/addon/sidebery) | Displays tabs vertically as a tree in the sidebar |
| [TabSearch](https://addons.mozilla.org/firefox/addon/tab_search) | Allows jumping between tabs by searching |
| [Temporary Containers](https://addons.mozilla.org/firefox/addon/temporary-containers) | Easy disposable isolated tabs (like private windows) |
| [uBlock Origin](https://addons.mozilla.org/firefox/addon/ublock-origin) | Blocks unwanted content |
