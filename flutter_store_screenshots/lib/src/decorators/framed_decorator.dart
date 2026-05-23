import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../models/screenshot_set.dart';

/// Default gradient used by [framedDecorator] when no [gradient] is provided.
const _defaultGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
);

/// Returns a [ScreenshotDecorator] that renders a gradient background with a
/// marketing title at the top, a [DeviceFrame] containing the app content in
/// the centre, and an optional subtitle at the bottom.
///
/// - [device] — the [DeviceInfo] used for the device frame mockup (e.g.
///   `Devices.ios.iPhone16ProMax`).
/// - [gradient] — background gradient. Defaults to an indigo gradient if
///   omitted.
///
/// The title and subtitle are sourced from each [StoreScreenshot]'s
/// `titleBuilder` / `subtitleBuilder` and are automatically passed in by the
/// framework — no extra wiring is required.
///
/// ## Example
/// ```dart
/// AppleScreenshotSet.iPhone67(
///   decorator: framedDecorator(
///     device: Devices.ios.iPhone16ProMax,
///     gradient: LinearGradient(
///       colors: [Color(0xFF1A237E), Color(0xFF7986CB)],
///     ),
///   ),
///   storeScreenshots: _myScreenshots(),
/// )
/// ```
ScreenshotDecorator framedDecorator({
  required DeviceInfo device,
  Gradient? gradient,
}) {
  return (
    BuildContext context,
    WidgetBuilder contentBuilder,
    String? Function(BuildContext)? titleBuilder,
    String? Function(BuildContext)? subtitleBuilder,
  ) {
    final title = titleBuilder?.call(context);
    final subtitle = subtitleBuilder?.call(context);

    return Container(
      decoration: BoxDecoration(gradient: gradient ?? _defaultGradient),
      child: Column(
        children: [
          // ── Title ──────────────────────────────────────────────────────────
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: Text(
                title,
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
                // Builder lets DeviceFrame inject the correct inner
                // MediaQuery before calling contentBuilder.
                screen: Builder(builder: contentBuilder),
              ),
            ),
          ),

          // ── Subtitle ───────────────────────────────────────────────────────
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
              child: Text(
                subtitle,
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
