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

# Install extensions (see list below)
```

user.js
-------
Sets a bunch of `about:config` options. Read the file for the specifics.

userChrome.css
--------------
Hides the tabs on the top of the window (replaced with an addon that puts tabs on the side)

Extensions
----------
- https://addons.mozilla.org/firefox/addon/clearurls
- https://addons.mozilla.org/firefox/addon/cliget
- https://addons.mozilla.org/firefox/downthemall
- https://addons.mozilla.org/firefox/addon/drag-select-link-text
- https://addons.mozilla.org/firefox/addon/feed-preview
- https://addons.mozilla.org/firefox/addon/multi-account-containers
- https://addons.mozilla.org/firefox/addon/google-search-link-fix
- https://addons.mozilla.org/firefox/addon/py3direct
- https://addons.mozilla.org/firefox/addon/sidebery
- https://addons.mozilla.org/firefox/addon/styl-us
- https://addons.mozilla.org/firefox/addon/tab_search
- https://addons.mozilla.org/firefox/addon/temporary-containers
- https://addons.mozilla.org/firefox/addon/to-google-translate/
- https://addons.mozilla.org/firefox/addon/ublacklist
- https://addons.mozilla.org/firefox/addon/ublock-origin
- https://addons.mozilla.org/firefox/addon/universal-bypass/
- https://addons.mozilla.org/firefox/addon/urls-list
- https://addons.mozilla.org/firefox/addon/violentmonkey
- https://addons.mozilla.org/firefox/addon/youtube-rss-finder
