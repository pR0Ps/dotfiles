// Personal Firefox Preferences
//
// If you aren't me then read up on the option before blindly applying.
// There are some tradeoffs in here you might not agree with.


// Don't warn when modifying about:config
user_pref("browser.aboutConfig.showWarning", false);


// ----- Preferences/Interface tweaks -----
// Compact UI (smaller back button, etc)
user_pref("browser.uidensity", 1);

// Use the platform's native title bar
// (This complements other tweaks that move the tabs from the title bar into a sidebar)
user_pref("browser.tabs.drawInTitlebar", false);

// Display the URL exactly as it was entered (don't trim slashes, remove http, etc)
user_pref("browser.urlbar.trimURLs", false);

// Force punycode for IDNs (mitigate domain spoofing attacks)
user_pref("network.IDN_show_punycode", true);

// Don't show search suggestions before history, bookmarks, etc
user_pref("browser.urlbar.matchBuckets", "general:5,suggestion:Infinity");

// Don't suggest open tabs when typing in the URL bar
user_pref("browser.urlbar.suggest.openpage", false);

// Don't suggest popular websites just because they're popular
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);

// Disable pasting and loading URLs with middle mouse button
user_pref("middlemouse.contentLoadURL", false);

// Enable spell check in all text boxes (default is just multiline)
user_pref("layout.spellcheckDefault", 2);

// Don't automatically copy selected text to clipboard (Linux-only feature)
user_pref("clipboard.autocopy", false);

// Force links to open in new tabs instead of new windows
user_pref("browser.link.open_newwindow", 3);
user_pref("browser.link.open_newwindow.restriction", 0);

// Disable Pocket
user_pref("extensions.pocket.enabled", false);

// Write session restore data every 30 seconds (default is 15)
user_pref("browser.sessionstore.interval", 30000);

// Show the edit screen when creating a bookmark
user_pref("browser.bookmarks.editDialog.showForNewBookmarks", true);

// Show bookmarks created on mobile
user_pref("browser.bookmarks.showMobileBookmarks", true);

// Always ask where to download files
user_pref("browser.download.useDownloadDir", false);

// Don't add downloads to recent files
user_pref("browser.download.manager.addToRecentDocs", false);

// Don't hide entries in the download actions when a file isn't associated with anything
user_pref("browser.download.hide_plugins_without_extensions", false);

// Set startup page (0=blank, 1=home, 2=last visited page, 3=resume previous session)
user_pref("browser.startup.page", 3);
user_pref("browser.startup.homepage", "about:blank");

// Don't check if FF is the default browser
user_pref("browser.shell.checkDefaultBrowser", false);

// Disable new tab page
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.url", "about:blank");


// ----- Privacy/Reduce unwanted traffic -----
// Disable sending the URL of the website where a plugin crashed
user_pref("dom.ipc.plugins.reportCrashURL", false);

// Disable recommendations
user_pref("extensions.getAddons.showPane", false); // Hide "Recommended" tab in about:addons
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// Disable studies and experiments
user_pref("app.normandy.enabled", false);
user_pref("messaging-system.rsexperimentloader.enabled", false);

// Disable network connectivity checking
user_pref("network.connectivity-service.enabled", false);
user_pref("network.manage-offline-status", false);

// Disable captive portal detection (attempts to hit an external URL)
user_pref("network.captive-portal-service.enabled", false);

// Disable location bar domain guessing (ie. trying x.com if x doesn't resolve)
user_pref("browser.fixup.alternate.enabled", false);
// Don't send user:pass to guessed domains if guessing is enabled
user_pref("browser.fixup.hide_user_pass", true);

// Don't submit content typed in the URL/search bar to search engines automatically
// (disables search suggestions)
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

// Don't start loading pages before the user hits enter or clicks a link
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("network.http.speculative-parallel-limit", 0);

// Disable prefetching of DNS and pages
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.prefetch-next", false);

// Don't send referer header cross-domain (0=always send, 1=base domain match, 2=full domain match)
user_pref("network.http.referer.XOriginPolicy", 1);

// Display true origin of premission prompts (don't allow sites to delegate to iframe/etc)
user_pref("permissions.delegation.enabled", false);


// ----- Security -----
// Don't allow being MITM'd by Microsoft's Family Safety system
user_pref("security.family_safety.mode", 0);

// Send DNS requests through SOCKS when SOCKS proxying is in use
user_pref("network.proxy.socks_remote_dns", true);

// Make rel=noopener implicit in certain cases
// (don't allow links to change the page they were opened from)
user_pref("dom.targetBlankNoOpener.enabled", true);

// Disable HSTS (replaced with the HTTPZ addon)
// HTTPZ automatically redirects HTTP -> HTTPS for every site.
// If a site is not connectable over HTTPS, it provides a *choice* on how to proceed.
// There is no way to tell Firefox to not collect HSTS-enabled sites as it discovers them.
// A workaround is to truncate `<profile>/SiteSecurityServiceState.txt` and make it read-only.
user_pref("network.stricttransportsecurity.preloadlist", false);


// ----- Disable unwanted APIs -----
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

// Disable access to low-level timing information
user_pref("dom.enable_user_timing", false);
user_pref("dom.enable_performance", false);
user_pref("dom.enable_resource_timing", false);

// Prevent accessibility services from accessing the browser
user_pref("accessibility.force_disabled", 1);

// Disable WebRTC
user_pref("media.peerconnection.enabled", false);

// Disable WebSockets
user_pref("network.websocket.max-connections", 0);

// Disable sending beacons and pings
user_pref("beacon.enabled", false);
user_pref("browser.send_pings", false);
// Require pings to at least be the same domain if enabled
user_pref("browser.send_pings.require_same_host", true);
