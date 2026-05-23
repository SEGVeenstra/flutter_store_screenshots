# Flutter Store Screenshots

![Flutter Store Screenshots preview](docs/preview.png)

A Flutter tool for **composing, previewing, and exporting App Store & Google Play screenshots** — all from a single Dart entry point, with full localisation support, device frames, and one-click bulk export.

---

## Features

- **Live preview** — run the tool as a regular Flutter desktop/web app and see your screenshots rendered in real time.
- **Locale switcher** — flip between every locale your app supports with a dropdown, without restarting.
- **Multiple screenshot sets** — configure separate sets for each device size (iPhone 6.7", Android phone, iPad, tablet, feature graphic …) and switch between them instantly.
- **Config inheritance** — set defaults at the app level, override them per set, override again per screenshot. Only set what differs.
- **Custom decorators** — bring your own `ScreenshotDecorator` to wrap each screenshot in a gradient background, device frame, marketing title, subtitle — whatever the store requires.
- **Localised marketing copy** — `titleBuilder` / `subtitleBuilder` receive a `BuildContext` that already has the correct locale active, so `AppLocalizations.of(ctx)` just works.
- **Bulk PNG export** — one button writes every locale × every set × every screenshot to `./screenshots/<set>/<locale>/` with descriptive file names (`01_login.png`, `02_home.png` …).
- **Built-in device frames** — `framedDecorator` and `featureGraphicDecorator` wrap your content in pixel-perfect device mockups out of the box, powered by the bundled `device_frame` package.

---

## Getting started

### Prerequisites

- Flutter **3.x** or later (desktop or web target recommended for the preview tool)
- Dart SDK **^3.0.0**

### Installation

Add the package to the `dependencies` of a dedicated screenshot app (typically kept at `<your_repo>/store_screenshots/` or as `<your_package>_example/`):

```yaml
# pubspec.yaml
dependencies:
  flutter_store_screenshots: ^0.0.1
```

> `device_frame` is bundled as a dependency of `flutter_store_screenshots`, so no separate entry is needed. You will still import it directly in your Dart files to reference `Devices.*` constants.

Then run:

```bash
flutter pub get
```

> **Tip:** Keep your screenshot project separate from your main app so it never ships to end-users. Import your app's widgets and localisation as a path dependency:
>
> ```yaml
> dependencies:
>   my_app:
>     path: ../my_app
> ```

---

## Usage

The entire tool is a single Flutter app. Your `main.dart` creates a `FlutterStoreScreenshotsApp` widget and passes it your screens, locales, and screenshot sets.

### Minimal example

```dart
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(
    FlutterStoreScreenshotsApp(
      locales: const [Locale('en'), Locale('de')],
      screenshotSets: [
        AppleScreenshotSet.iPhone67(
          decorator: framedDecorator(
            device: Devices.ios.iPhone16ProMax,
          ),
          storeScreenshots: [
            StoreScreenshot(
              name: 'home',
              builder: (_) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  );
}
```

Run it on macOS, Linux, Windows, or in Chrome:

```bash
flutter run -d macos   # or: -d chrome
```

---

## Core concepts

### `FlutterStoreScreenshotsApp`

The root widget. It renders the preview UI (toolbar + scrollable canvas) and orchestrates export.

| Parameter | Type | Description |
|---|---|---|
| `locales` | `List<Locale>` | All locales your app supports. Populates the locale dropdown. |
| `screenshotSets` | `List<ScreenshotSet>` | The device/format configurations to preview. |
| `localizationsDelegates` | `List<LocalizationsDelegate>?` | Your app's generated ARB delegates (e.g. `AppLocalizations.delegate`). Forwarded to `MaterialApp` so `Localizations.override` works correctly inside screenshots. |
| `theme` | `ThemeData?` | App-level default theme. Can be overridden by a set or individual screenshot. |

---

### `ScreenshotSet`

A **named group** of screenshots that share a common configuration. Think of one set per device/format combination you need to submit to the store.

| Parameter | Type | Description |
|---|---|---|
| `name` | `String` | Display name shown in the set selector (e.g. `'iOS Phone 6.7"'`). |
| `targetPlatform` | `TargetPlatform?` | Platform injected into the resolved theme for all screenshots in this set. |
| `size` | `Size?` | Logical pixel size (canvas dimensions). At least one of `ScreenshotSet.size` or `StoreScreenshot.size` must be provided. |
| `pixelDensity` | `double?` | Device pixel ratio injected via `MediaQuery`. |
| `theme` | `ThemeData?` | Overrides the app-level theme for this set. |
| `decorator` | `ScreenshotDecorator?` | Applies a shared visual wrapper (background, device frame, text) to every screenshot in the set. |
| `storeScreenshots` | `List<StoreScreenshot>` | The individual screenshots belonging to this set. |

---

### `StoreScreenshot`

Configuration for **a single screenshot**. Every field except `builder` is optional; missing values are inherited from the parent `ScreenshotSet`, then from `FlutterStoreScreenshotsApp`.

| Parameter | Type | Description |
|---|---|---|
| `name` | `String?` | Used as a suffix in the exported file name (e.g. `'login'` → `01_login.png`). |
| `builder` | `WidgetBuilder` | **Required.** Returns the app screen widget. |
| `titleBuilder` | `String? Function(BuildContext)?` | Returns a marketing title string. The `BuildContext` has the correct locale, so `AppLocalizations.of(ctx)` returns the right language. |
| `subtitleBuilder` | `String? Function(BuildContext)?` | Same as `titleBuilder` but for the subtitle. |
| `locale` | `Locale?` | Overrides the set and app-level locale for this screenshot only. |
| `targetPlatform` | `TargetPlatform?` | Overrides the set-level platform. |
| `size` | `Size?` | Overrides the set-level canvas size. |
| `pixelDensity` | `double?` | Overrides the set-level pixel density. |
| `theme` | `ThemeData?` | Overrides the set-level theme. |

---

### `ScreenshotDecorator`

```dart
typedef ScreenshotDecorator =
    Widget Function(
      BuildContext context,
      WidgetBuilder contentBuilder,
      String? Function(BuildContext)? titleBuilder,
      String? Function(BuildContext)? subtitleBuilder,
    );
```

A `ScreenshotDecorator` is a function that **owns the full canvas layout**. It receives:

- `context` — build context at canvas level. `MediaQuery.of(context).size` equals the configured canvas size.
- `contentBuilder` — the raw app-screen builder. **Pass this to a `DeviceFrame`** (or any wrapper widget) so the frame can inject the correct inner `MediaQuery` for the app content:
  ```dart
  DeviceFrame(
    device: Devices.ios.iPhone16ProMax,
    screen: Builder(builder: contentBuilder),
  )
  ```
- `titleBuilder` / `subtitleBuilder` — call with `context` to get the localised string:
  ```dart
  final title = titleBuilder?.call(context);
  ```

---

## Preset sets & built-in decorators

`flutter_store_screenshots` ships with pre-configured `ScreenshotSet` subclasses for every major store format, and two decorator factory functions that produce polished, device-framed screenshots with no boilerplate.

### `AppleScreenshotSet`

| Constructor | Canvas (logical px) | Density | Physical px | Store target |
|---|---|---|---|---|
| `.iPhone69(...)` | 440 × 956 | 3× | 1320 × 2868 | App Store 6.9" iPhone |
| `.iPhone67(...)` | 430 × 932 | 3× | 1290 × 2796 | App Store 6.7" iPhone |
| `.iPadPro129(...)` | 1024 × 1366 | 2× | 2048 × 2732 | App Store iPad Pro 12.9" |

### `AndroidScreenshotSet`

| Constructor | Canvas (logical px) | Density | Physical px | Store target |
|---|---|---|---|---|
| `.phone(...)` | 412 × 892 | 2.625× | ≈1081 × 2341 | Google Play phone |
| `.tablet7(...)` | 600 × 960 | 2× | 1200 × 1920 | Google Play 7" tablet |
| `.tablet10(...)` | 800 × 1280 | 2× | 1600 × 2560 | Google Play 10" tablet |
| `.featureGraphic(...)` | 1024 × 500 | 1× | 1024 × 500 | Google Play Feature Graphic |

Each constructor accepts `decorator` (optional) and `storeScreenshots` (required).

### `framedDecorator`

Renders a gradient background, optional marketing title at the top, a `DeviceFrame` in the centre, and an optional subtitle at the bottom. Title and subtitle are sourced automatically from each `StoreScreenshot`'s `titleBuilder` / `subtitleBuilder`.

```dart
framedDecorator({
  required DeviceInfo device,
  Gradient? gradient,   // defaults to a neutral indigo gradient
})
```

### `featureGraphicDecorator`

Renders the Google Play Feature Graphic layout: marketing text on the left, device mockup on the right.

```dart
featureGraphicDecorator({
  DeviceInfo? device,   // defaults to Devices.android.samsungGalaxyS25
  Gradient? gradient,   // defaults to a dark-green gradient
})
```

---

## Full example with device frames and localisation

```dart
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    FlutterStoreScreenshotsApp(
      locales: const [Locale('en'), Locale('de'), Locale('nl')],
      localizationsDelegates: const [AppLocalizations.delegate],
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      screenshotSets: [
        AppleScreenshotSet.iPhone67(
          decorator: framedDecorator(
            device: Devices.ios.iPhone16ProMax,
            gradient: const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF7986CB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          storeScreenshots: [
            StoreScreenshot(
              name: 'login',
              titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
              subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginSubtitle,
              builder: (_) => const LoginScreen(),
            ),
            StoreScreenshot(
              name: 'home',
              titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
              subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
              builder: (_) => const HomeScreen(),
            ),
          ],
        ),
        AndroidScreenshotSet.phone(
          decorator: framedDecorator(
            device: Devices.android.samsungGalaxyS25,
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          storeScreenshots: [
            // ... same screenshots
          ],
        ),
        AndroidScreenshotSet.featureGraphic(
          decorator: featureGraphicDecorator(),
          storeScreenshots: [
            StoreScreenshot(
              name: 'feature_graphic',
              titleBuilder: (_) => 'My App',
              subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotFeatureTitle,
              builder: (_) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  );
}
```

> **Writing a fully custom decorator?** You can still pass any `ScreenshotDecorator` function to the `decorator` parameter — the preset classes are just a convenience. See [ScreenshotDecorator](#screenshotdecorator) above for the full API.


---

## Exporting screenshots

Click the **download icon** (↓) in the toolbar to export every locale × every set × every screenshot at once. Files are written to:

```
<project_root>/screenshots/<set_name>/<locale>/
  01_login.png
  02_home.png
  ...
```

Once the export is complete, click the **folder icon** to open the output directory in Finder / Explorer.

> The export runs entirely on the Flutter rendering engine — no external tools, simulators, or screenshot drivers required.

---

## Config inheritance cheat-sheet

Values are resolved in this order (first non-null wins):

```
StoreScreenshot  →  ScreenshotSet  →  FlutterStoreScreenshotsApp
```

For example, `pixelDensity`:

1. `StoreScreenshot.pixelDensity`
2. `ScreenshotSet.pixelDensity`
3. Falls back to `1.0`

For `locale`:

1. `StoreScreenshot.locale`
2. `ScreenshotSet.locale`
3. The locale currently selected in the toolbar dropdown

---

## Tips

**Reuse the same screens for every device** — define your screenshots once and pass the list to multiple preset sets:

```dart
List<StoreScreenshot> _myScreenshots() => [
  StoreScreenshot(name: 'home', builder: (_) => const HomeScreen()),
  StoreScreenshot(name: 'detail', builder: (_) => const DetailScreen()),
];

screenshotSets: [
  AppleScreenshotSet.iPhone67(decorator: myDecorator, storeScreenshots: _myScreenshots()),
  AppleScreenshotSet.iPadPro129(decorator: myDecorator, storeScreenshots: _myScreenshots()),
  AndroidScreenshotSet.phone(decorator: myDecorator, storeScreenshots: _myScreenshots()),
],
```

**Google Play Feature Graphic** — use `AndroidScreenshotSet.featureGraphic` with the built-in `featureGraphicDecorator` for an instant branding layout (text left, device right):

```dart
AndroidScreenshotSet.featureGraphic(
  decorator: featureGraphicDecorator(),
  storeScreenshots: [
    StoreScreenshot(
      name: 'feature_graphic',
      titleBuilder: (_) => 'My App',
      subtitleBuilder: (ctx) => AppLocalizations.of(ctx).featureTagline,
      builder: (_) => const HomeScreen(),
    ),
  ],
),
```

**Force a specific locale for a set** — useful when your Play Console submission requires the screenshots to be in a fixed language regardless of the toolbar selection:

```dart
ScreenshotSet(
  name: 'iOS Phone 6.7" (EN)',
  locale: const Locale('en'),
  ...
),
```

---

## Additional information

- File issues and feature requests on [GitHub](https://github.com/SEGVeenstra/flutter_store_screenshots/issues).
- Contributions are welcome — please open an issue first to discuss larger changes.
- See the [`example/`](example/) folder for a full working project with four screens, four locales, and five screenshot sets including a Google Play Feature Graphic.
