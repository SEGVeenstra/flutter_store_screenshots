import 'package:flutter/material.dart';

/// Configuration for a single store screenshot.
///
/// All properties except [builder] are optional and can be inherited
/// from the parent [ScreenshotSet] or the [FlutterStoreScreenshotsApp].
class StoreScreenshot {
  const StoreScreenshot({
    this.name,
    this.titleBuilder,
    this.subtitleBuilder,
    this.locale,
    this.targetPlatform,
    this.size,
    this.pixelDensity,
    this.theme,
    required this.builder,
  });

  /// Optional name used as a suffix in the exported file name
  /// (e.g. `'login'` → `01_login.png`). When absent the file is named by
  /// index only (e.g. `01.png`).
  final String? name;

  /// Optional builder that returns a localized marketing title for use by
  /// the [ScreenshotDecorator]. Called with the decorator's [BuildContext],
  /// which already has the correct [Localizations] for the screenshot's
  /// locale, so `AppLocalizations.of(ctx)` returns the right language.
  final String? Function(BuildContext)? titleBuilder;

  /// Optional builder that returns a localized marketing subtitle for use by
  /// the [ScreenshotDecorator]. Same locale semantics as [titleBuilder].
  final String? Function(BuildContext)? subtitleBuilder;

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

  /// Builder for the screenshot content.
  final WidgetBuilder builder;
}
