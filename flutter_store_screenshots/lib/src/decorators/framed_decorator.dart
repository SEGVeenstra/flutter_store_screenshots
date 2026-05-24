import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../widgets/screenshot_content.dart';

/// Default gradient used by [framedCanvas] when no [gradient] is provided.
const _defaultGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
);

/// Returns a [WidgetBuilder] that renders a gradient background with an
/// optional marketing [title] at the top, a [DeviceFrame] containing
/// [child] in the centre, and an optional [subtitle] at the bottom.
///
/// Use this as [StoreScreenshot.builder] for the common single-device,
/// portrait screenshot layout:
///
/// ```dart
/// StoreScreenshot(
///   name: 'home',
///   builder: framedCanvas(
///     device: Devices.ios.iPhone16ProMax,
///     child: (_) => HomeScreen(),
///     title: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
///     subtitle: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
///   ),
/// )
/// ```
///
/// - [device] — the [DeviceInfo] used for the device frame mockup.
/// - [child] — builder for the app screen rendered inside the device frame.
/// - [title] — optional localized marketing title shown above the device.
///   The [BuildContext] passed to this callback already has the correct
///   locale active, so `AppLocalizations.of(ctx)` returns the right language.
/// - [subtitle] — optional localized subtitle shown below the device.
/// - [gradient] — background gradient. Defaults to an indigo gradient.
WidgetBuilder framedCanvas({
  required DeviceInfo device,
  required WidgetBuilder child,
  String? Function(BuildContext)? title,
  String? Function(BuildContext)? subtitle,
  Gradient? gradient,
}) {
  return (BuildContext context) {
    final titleText = title?.call(context);
    final subtitleText = subtitle?.call(context);

    return Container(
      decoration: BoxDecoration(gradient: gradient ?? _defaultGradient),
      child: Column(
        children: [
          // ── Title ──────────────────────────────────────────────────────────
          if (titleText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),

          // ── Device frame ───────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: DeviceFrame(
                device: device,
                // ScreenshotContent handles Navigator isolation so the app
                // screen always renders as the root route.
                screen: ScreenshotContent(builder: child),
              ),
            ),
          ),

          // ── Subtitle ───────────────────────────────────────────────────────
          if (subtitleText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
              child: Text(
                subtitleText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  };
}
