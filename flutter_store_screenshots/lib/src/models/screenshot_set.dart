import 'package:flutter/material.dart';

import 'store_screenshot.dart';

/// Signature for a function that wraps the raw app-content builder inside a
/// fully composed screenshot canvas (background, device frame, slogans, etc.).
///
/// - [context] is the build context at canvas level (MediaQuery.size equals
///   the canvas size from [ScreenshotSet.size]).
/// - [contentBuilder] is the raw app-screen builder. Pass it directly to a
///   device-frame widget (e.g. `DeviceFrame(screen: Builder(builder: contentBuilder))`)
///   so the frame can inject the correct inner [MediaQuery] for the app content.
/// - [title] and [subtitle] come from [StoreScreenshot.title] /
///   [StoreScreenshot.subtitle] — use them for marketing copy.
typedef ScreenshotDecorator =
    Widget Function(
      BuildContext context,
      WidgetBuilder contentBuilder,
      String? title,
      String? subtitle,
    );

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
    this.decorator,
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

  /// Optional decorator applied to every screenshot in this set.
  ///
  /// When set, the decorator is responsible for the full canvas layout:
  /// it receives the raw [WidgetBuilder] for the app content and should
  /// embed it inside a device frame so the frame can inject the correct
  /// inner [MediaQuery]. See [ScreenshotDecorator] for details.
  final ScreenshotDecorator? decorator;

  /// The screenshots that belong to this set.
  final List<StoreScreenshot> storeScreenshots;
}
