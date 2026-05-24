import 'package:flutter/material.dart';

/// Configuration for a single store screenshot.
///
/// All properties except [builder] are optional and can be inherited
/// from the parent [ScreenshotSet] or the [FlutterStoreScreenshotsApp].
class StoreScreenshot {
  const StoreScreenshot({
    this.name,
    this.locale,
    this.targetPlatform,
    this.size,
    this.pixelDensity,
    this.theme,
    this.captureDelay,
    required this.builder,
  });

  /// Optional name used as a suffix in the exported file name
  /// (e.g. `'login'` → `01_login.png`). When absent the file is named by
  /// index only (e.g. `01.png`).
  final String? name;

  /// The locale for this screenshot. Overrides the parent set's locale and
  /// the app-level selected locale when set.
  final Locale? locale;

  /// The target platform for this screenshot. Overrides the parent set's
  /// [targetPlatform] when set, and always overrides the [platform] field
  /// inside a resolved [theme].
  final TargetPlatform? targetPlatform;

  /// The logical pixel size of this screenshot. Overrides the parent set's
  /// [size] when set.
  final Size? size;

  /// The device pixel ratio for this screenshot, injected via [MediaQuery].
  /// Overrides the parent set's [pixelDensity] when set.
  final double? pixelDensity;

  /// The theme applied to this screenshot. Overrides the parent set's [theme]
  /// and the app-level theme when set. [targetPlatform] always overrides
  /// the [platform] field baked into this theme.
  final ThemeData? theme;

  /// Optional delay applied after the widget is rendered but before the
  /// screenshot is captured. Overrides the parent set's [captureDelay].
  ///
  /// Useful when the screen contains animations or images (e.g. from
  /// `cached_network_image`) that play a fade-in on first render — set this
  /// to a duration slightly longer than the animation to ensure the capture
  /// shows the fully-loaded state.
  final Duration? captureDelay;

  /// Builder for the **full screenshot canvas**.
  ///
  /// The [BuildContext] provided to this builder has the correct [Theme],
  /// [Locale] (via [Localizations.override]), and [MediaQuery] (canvas size)
  /// already set up by the framework, so `AppLocalizations.of(ctx)` returns
  /// the right language and `MediaQuery.sizeOf(ctx)` equals the canvas size.
  ///
  /// Use [ScreenshotContent] inside this builder to embed one or more
  /// isolated app screens. Wrap each [ScreenshotContent] in a [DeviceFrame]
  /// from the `device_frame` package when you want a device mockup:
  ///
  /// ```dart
  /// builder: (context) => Stack(
  ///   children: [
  ///     // background, text, any widgets ...
  ///     DeviceFrame(
  ///       device: Devices.ios.iPhone16ProMax,
  ///       screen: ScreenshotContent(builder: (_) => HomeScreen()),
  ///     ),
  ///   ],
  /// ),
  /// ```
  final WidgetBuilder builder;
}
