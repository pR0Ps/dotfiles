// Personal Firefox Preferences
//
// If you aren't me then read up on the option before blindly applying.
// There are some tradeoffs in here you might not agree with.
//
// Information on preferences can be found in the source code. See https://searchfox.org/


// Don't warn when modifying about:config
user_pref("browser.aboutConfig.showWarning", false);

// Enable loading styles from userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);


// ----- Interface tweaks -----
// Compact UI (smaller back button, etc)
user_pref("browser.uidensity", 1);

// Use the platform's native title bar
// (This complements the addon + CSS tweaks that moves the tabs from the title bar into a sidebar)
user_pref("browser.tabs.inTitlebar", 0);

// Display the URL exactly as it was entered (don't trim slashes, remove http, etc)
user_pref("browser.urlbar.trimURLs", false);

// Force punycode for IDNs (mitigate domain spoofing attacks)
user_pref("network.IDN_show_punycode", true);

// Show 30 URL bar suggestions (default is 10)
user_pref("browser.urlbar.maxRichResults", 30);

// Enable basic offline unit converter in URL bar
user_pref("browser.urlbar.unitConversion.enabled", true);

// Reclassify and restyle search results in the history as search suggestions
user_pref("browser.urlbar.restyleSearches", true);

// Show search suggestions after history, bookmarks, etc
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);

// Don't suggest open tabs when typing in the URL bar
// (replaced with the TabSearch addon)
user_pref("browser.urlbar.suggest.openpage", false);

// Don't suggest popular websites just because they're popular
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);

// Force links to open in new tabs instead of new windows
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 0);

// Write session restore data every 30 seconds (default is 15)
user_pref("browser.sessionstore.interval", 30000);

// Show the edit screen when creating a bookmark
user_pref("browser.bookmarks.editDialog.showForNewBookmarks", true);

// Show bookmarks created on mobile
user_pref("browser.bookmarks.showMobileBookmarks", true);

// Always ask where to download files
user_pref("browser.download.useDownloadDir", false);

// Always ask to open or save files
// (Also allows checking the filesize before starting the download)
user_pref("browser.download.improvements_to_download_panel", false);

// Don't automatically show the download popup when starting to download a file
user_pref("browser.download.alwaysOpenPanel", false);

// Don't add downloads to recent files
user_pref("browser.download.manager.addToRecentDocs", false);

// Don't hide entries in the download actions when a file isn't associated with anything
user_pref("browser.download.hide_plugins_without_extensions", false);

// Set startup page (0=blank, 1=home, 2=last visited page, 3=resume previous session)
user_pref("browser.startup.page", 3);
user_pref("browser.startup.homepage", "about:blank");

// Disable new tab page
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.url", "about:blank");

// Revove ad for Firefox VPN when opening a new private window
user_pref("browser.privatebrowsing.vpnpromourl", "");

// Remove full-screen overlay ad (wtf?!) for Firefox VPN
// ref: https://bugzilla.mozilla.org/show_bug.cgi?id=1835182
user_pref("browser.vpn_promo.enabled", false);

// ----- Preference tweaks -----
// Don't check if FF is the default browser
user_pref("browser.shell.checkDefaultBrowser", false);

// Don't show the "<site> is now full screen" warning
user_pref("full-screen-api.warning.timeout", 0);

// Don't show the picture-in-picture toggle
// (still available on right-click or shift + right-click)
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);

// Disable pasting and loading URLs with middle mouse button
user_pref("middlemouse.contentLoadURL", false);

// Don't automatically copy selected text to clipboard (Linux-only feature)
user_pref("clipboard.autocopy", false);

// Enable spell check in all text boxes (default is just multiline)
user_pref("layout.spellcheckDefault", 2);

// Increase the amount of history that is retained
user_pref("places.history.expiration.max_pages", 10000000);

// When loading media, always try to load the entire file immediately
// Increase the cache size to reduce the likelihood of a huge file evicting everything else
user_pref("media.cache_readahead_limit", 86400); // amount of future media to preload (1 day in seconds)
user_pref("media.cache_resume_threshold", 86400); // resume loading when less seconds than this of future media is loaded
user_pref("media.cache_size", 1024000); // Increase on-disk media cache size to 1GB (default is 500MB)


// ----- Privacy/Reduce unwanted traffic -----
// Disable sending the URL of the website where a plugin crashed
user_pref("dom.ipc.plugins.reportCrashURL", false);

// Disable recommendations
user_pref("extensions.getAddons.showPane", false); // Hides the "Recommended" tab in about:addons
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);

// Disable sponsored searches in the URL bar
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.urlbar.sponsoredTopSites", false);

// Disable studies and experiments
// Telemetry is left enabled since I want my usage to be represented in their
// collected data. However, I'm not comfortable with my browser running random
// experiments, installing addons, or changing its settings.
user_pref("app.normandy.enabled", false);
user_pref("messaging-system.rsexperimentloader.enabled", false);

// Disable network connectivity checking
user_pref("network.connectivity-service.enabled", false);
user_pref("network.manage-offline-status", false);

// Disable captive portal detection (attempts to hit an external URL)
user_pref("network.captive-portal-service.enabled", false);

// Disable location bar domain guessing (ie. trying x.com if x doesn't resolve)
user_pref("browser.fixup.alternate.enabled", false);
user_pref("browser.fixup.hide_user_pass", true); // Don't send user:pass to guessed domains if guessing is enabled

// Don't submit content typed in the URL/search bar to external sites automatically
// (disables search suggestions)
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.suggest.enabled.private", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);

// Don't start loading pages before the user hits enter or clicks a link
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("network.http.speculative-parallel-limit", 0);

// Disable prefetching of DNS and pages
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.prefetch-next", false);

// Don't send referer header cross-domain (0=always send, 1=base domain match, 2=full domain match)
user_pref("network.http.referer.XOriginPolicy", 1);

// Display true origin of permission prompts (don't allow sites to delegate to iframe/other)
user_pref("permissions.delegation.enabled", false);


// ----- Security -----
// Don't allow being MITM'd by Microsoft's Family Safety system
user_pref("security.family_safety.mode", 0);

// Disable DNS over HTTPS (use the system-configured resolver instead)
// 0=default, 1=reserved, 2=DoH first, 3=DoH only, 4=reserved, 5=off
user_pref("network.trr.mode", 5);

// Send DNS requests through SOCKS when SOCKS proxying is in use
user_pref("network.proxy.socks_remote_dns", true);

// Make rel=noopener implicit in certain cases
// (don't allow links to change the page they were opened from)
user_pref("dom.targetBlankNoOpener.enabled", true);

// Automatically redirect to HTTPS versions of websites
user_pref("dom.security.https_only_mode", true);

// Disable HSTS
// Disabling this provides a *choice* on how to proceed if a site isn't working over HTTPS
// There is no way to tell Firefox to not collect HSTS-enabled sites as it discovers them.
// A workaround is to truncate `<profile>/SiteSecurityServiceState.txt` and make it read-only.
user_pref("network.stricttransportsecurity.preloadlist", false);


// ----- Disable unwanted APIs/features -----
// Disable Pocket
user_pref("extensions.pocket.enabled", false);

// Prevent sites from messing with window chrome, size, and position
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_open_feature.toolbar", true);
user_pref("dom.disable_window_move_resize", true);

// Block popups
user_pref("dom.disable_open_during_load", true);

// Disable service workers
user_pref("dom.serviceWorkers.enabled", false);

// Disable the vibration API
user_pref("dom.vibrator.enabled", false);

// Disable the battery API
user_pref("dom.battery.enabled", false);

// Disable VR support
user_pref("dom.vr.enabled", false);

// Disable all DRM content (EME = Encrypted Media Extensions)
user_pref("media.eme.enabled", false);
// Don't prompt to enable Widevine
user_pref("media.gmp-widevinecdm.visible", false);

// Disable access to low-level timing information
user_pref("dom.enable_performance", false);
//user_pref("dom.enable_resource_timing", false);  // left enabled in order to make Cloudflare-protected sites work

// Prevent accessibility services from accessing the browser
user_pref("accessibility.force_disabled", 1);

// Disable WebRTC
user_pref("media.peerconnection.enabled", false);

// Disable sending beacons and pings
user_pref("beacon.enabled", false);
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);  // Require pings to at least be the same domain if enabled
