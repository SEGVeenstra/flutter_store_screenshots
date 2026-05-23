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
    this.captureDelay,
    this.showBackButton = false,
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

  /// Optional delay applied after the widget is rendered but before the
  /// screenshot is captured. Overrides the parent set's [captureDelay].
  ///
  /// Useful when the screen contains animations or images (e.g. from
  /// `cached_network_image`) that play a fade-in on first render — set this
  /// to a duration slightly longer than the animation to ensure the capture
  /// shows the fully-loaded state.
  final Duration? captureDelay;

  /// Whether to allow the rendered screen to show a back button.
  ///
  /// By default (`false`) the content is wrapped in a fresh [Navigator] so
  /// the screen always appears as the root route — no back button is shown
  /// in the [AppBar], regardless of the surrounding navigation stack.
  ///
  /// Set to `true` when you intentionally want to capture a screen that
  /// has a back button (e.g. a detail page that should show the ← icon).
  final bool showBackButton;

  /// Builder for the screenshot content.
  final WidgetBuilder builder;
}
