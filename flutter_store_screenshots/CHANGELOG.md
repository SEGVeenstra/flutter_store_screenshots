## 0.1.0

* Initial release.
* `FlutterStoreScreenshotsApp` — a Flutter desktop/web app that renders and previews all screenshots live, with a locale switcher and set switcher.
* `ScreenshotSet` model with config inheritance: set defaults at the app level and override per set or per individual screenshot.
* `StoreScreenshot` model for declaring individual screenshots with optional title/subtitle builders that receive a locale-aware `BuildContext`.
* `AppleScreenshotSet` and `AndroidScreenshotSet` presets with the correct required resolutions for App Store and Google Play.
* `framedDecorator` — wraps screenshot content in a device frame (powered by `device_frame`) with a customisable gradient background.
* `featureGraphicDecorator` — generates a Google Play feature graphic from your screenshot content.
* `panoramicDecorator` — renders a wide panoramic layout for marketing banners.
* Bulk PNG export: writes every locale × every set × every screenshot to `./screenshots/<set>/<locale>/`.
