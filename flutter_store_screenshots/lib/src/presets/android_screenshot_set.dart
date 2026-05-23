import 'package:flutter/material.dart';

import '../models/screenshot_set.dart';

/// Pre-configured [ScreenshotSet] subclasses for **Google Play Store** device
/// sizes.
///
/// Each named constructor pre-fills the correct canvas [size], [pixelDensity],
/// and [targetPlatform] for its store format. Only [storeScreenshots] is
/// required; [decorator] is optional and can be provided using the built-in
/// [framedDecorator] or [featureGraphicDecorator] helpers.
///
/// ## Example
/// ```dart
/// import 'package:device_frame/device_frame.dart';
/// import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';
///
/// AndroidScreenshotSet.phone(
///   decorator: framedDecorator(
///     device: Devices.android.samsungGalaxyS25,
///     gradient: LinearGradient(
///       colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
///     ),
///   ),
///   storeScreenshots: _myScreenshots(),
/// )
/// ```
class AndroidScreenshotSet extends ScreenshotSet {
  /// Google Play — Android phone.
  ///
  /// Canvas: 412 × 892 logical px · 2.625× density → **≈1081 × 2341** physical px.
  AndroidScreenshotSet.phone({super.decorator, required super.storeScreenshots})
    : super(
        name: 'Google Play Phone',
        targetPlatform: TargetPlatform.android,
        size: const Size(412, 892),
        pixelDensity: 2.625,
      );

  /// Google Play — 7" tablet.
  ///
  /// Canvas: 600 × 960 logical px · 2× density → **1200 × 1920** physical px.
  AndroidScreenshotSet.tablet7({
    super.decorator,
    required super.storeScreenshots,
  }) : super(
         name: 'Google Play 7" Tablet',
         targetPlatform: TargetPlatform.android,
         size: const Size(600, 960),
         pixelDensity: 2.0,
       );

  /// Google Play — 10" tablet.
  ///
  /// Canvas: 800 × 1280 logical px · 2× density → **1600 × 2560** physical px.
  AndroidScreenshotSet.tablet10({
    super.decorator,
    required super.storeScreenshots,
  }) : super(
         name: 'Google Play 10" Tablet',
         targetPlatform: TargetPlatform.android,
         size: const Size(800, 1280),
         pixelDensity: 2.0,
       );

  /// Google Play — Feature Graphic (landscape banner).
  ///
  /// Canvas: 1024 × 500 logical px · 1× density → **1024 × 500** physical px.
  ///
  /// Use with [featureGraphicDecorator] for a ready-made branding layout:
  /// ```dart
  /// AndroidScreenshotSet.featureGraphic(
  ///   decorator: featureGraphicDecorator(),
  ///   storeScreenshots: [
  ///     StoreScreenshot(
  ///       name: 'feature_graphic',
  ///       titleBuilder: (ctx) => AppLocalizations.of(ctx).featureTitle,
  ///       subtitleBuilder: (ctx) => AppLocalizations.of(ctx).featureSubtitle,
  ///       builder: (_) => const HomeScreen(),
  ///     ),
  ///   ],
  /// )
  /// ```
  AndroidScreenshotSet.featureGraphic({
    super.decorator,
    required super.storeScreenshots,
  }) : super(
         name: 'Google Play Feature Graphic',
         targetPlatform: TargetPlatform.android,
         size: const Size(1024, 500),
         pixelDensity: 1.0,
       );
}
