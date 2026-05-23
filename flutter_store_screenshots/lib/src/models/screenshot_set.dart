import 'package:flutter/material.dart';

import 'store_screenshot.dart';

/// A named group of store screenshots that share common configuration.
///
/// Values set on this class serve as defaults for all [storeScreenshots]
/// within the set. Individual [StoreScreenshot] instances can override
/// any of these values.
class ScreenshotSet {
  const ScreenshotSet({
    required this.name,
    this.locale,
    this.targetPlatform,
    this.size,
    this.pixelDensity,
    this.theme,
    required this.storeScreenshots,
  });

  /// Display name shown in the set selector dropdown.
  final String name;

  /// Default locale for all screenshots in this set. Overrides the
  /// app-level selected locale.
  final Locale? locale;

  /// Default target platform for all screenshots in this set. Always
  /// overrides the [platform] field inside a resolved [theme].
  final TargetPlatform? targetPlatform;

  /// Default logical pixel size for all screenshots in this set.
  /// At least one of [ScreenshotSet.size] or [StoreScreenshot.size]
  /// must be provided.
  final Size? size;

  /// Default device pixel ratio for all screenshots in this set.
  final double? pixelDensity;

  /// Default theme for all screenshots in this set. Overrides the
  /// app-level theme. [targetPlatform] always overrides the [platform]
  /// field baked into this theme.
  final ThemeData? theme;

  /// The screenshots that belong to this set.
  final List<StoreScreenshot> storeScreenshots;
}
