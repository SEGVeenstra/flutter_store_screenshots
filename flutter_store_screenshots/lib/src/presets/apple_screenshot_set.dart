import 'package:flutter/material.dart';

import '../models/screenshot_set.dart';

/// Pre-configured [ScreenshotSet] subclasses for **Apple App Store** device
/// sizes.
///
/// Each named constructor pre-fills the correct canvas [size], [pixelDensity],
/// and [targetPlatform] for its store format. Only [storeScreenshots] is
/// required.
///
/// ## Example
/// ```dart
/// import 'package:device_frame/device_frame.dart';
/// import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';
///
/// AppleScreenshotSet.iPhone67(
///   storeScreenshots: [
///     StoreScreenshot(
///       name: 'home',
///       builder: framedCanvas(
///         device: Devices.ios.iPhone16ProMax,
///         child: (_) => HomeScreen(),
///         title: (ctx) => AppLocalizations.of(ctx).homeTitle,
///       ),
///     ),
///   ],
/// )
/// ```
class AppleScreenshotSet extends ScreenshotSet {
  /// App Store — iPhone 6.9" display.
  ///
  /// Canvas: 440 × 956 logical px · 3× density → **1320 × 2868** physical px.
  AppleScreenshotSet.iPhone69({
    super.captureDelay,
    required super.storeScreenshots,
  }) : super(
         name: 'App Store iPhone 6.9"',
         targetPlatform: TargetPlatform.iOS,
         size: const Size(440, 956),
         pixelDensity: 3.0,
       );

  /// App Store — iPhone 6.7" display.
  ///
  /// Canvas: 430 × 932 logical px · 3× density → **1290 × 2796** physical px.
  AppleScreenshotSet.iPhone67({
    super.captureDelay,
    required super.storeScreenshots,
  }) : super(
         name: 'App Store iPhone 6.7"',
         targetPlatform: TargetPlatform.iOS,
         size: const Size(430, 932),
         pixelDensity: 3.0,
       );

  /// App Store — iPad Pro 12.9" display.
  ///
  /// Canvas: 1024 × 1366 logical px · 2× density → **2048 × 2732** physical px.
  AppleScreenshotSet.iPadPro129({
    super.captureDelay,
    required super.storeScreenshots,
  }) : super(
         name: 'App Store iPad Pro 12.9"',
         targetPlatform: TargetPlatform.iOS,
         size: const Size(1024, 1366),
         pixelDensity: 2.0,
       );
}
