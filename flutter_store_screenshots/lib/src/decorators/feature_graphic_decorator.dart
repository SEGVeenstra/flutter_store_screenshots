import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../widgets/screenshot_content.dart';

/// Default gradient used by [featureGraphicCanvas] when no [gradient] is
/// provided.
const _defaultGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
);

/// Returns a [WidgetBuilder] for a **Google Play Feature Graphic**
/// (1024×500 px landscape banner).
///
/// The layout places marketing text on the left and a device mockup on the
/// right:
///
/// ```
/// ┌──────────────────────────────────────────┐
/// │  [title]                  ┌──────────┐   │
/// │  [subtitle]               │  device  │   │
/// │                           └──────────┘   │
/// └──────────────────────────────────────────┘
/// ```
///
/// Use this as [StoreScreenshot.builder]:
///
/// ```dart
/// StoreScreenshot(
///   name: 'feature_graphic',
///   builder: featureGraphicCanvas(
///     child: (_) => HomeScreen(),
///     title: (ctx) => AppLocalizations.of(ctx).featureTitle,
///     subtitle: (ctx) => AppLocalizations.of(ctx).featureSubtitle,
///   ),
/// )
/// ```
///
/// - [device] — the [DeviceInfo] for the right-side device mockup.
///   Defaults to `Devices.android.samsungGalaxyS25`.
/// - [child] — builder for the app screen rendered inside the device frame.
/// - [title] — optional localized title shown on the left.
/// - [subtitle] — optional localized subtitle shown below the title.
/// - [gradient] — background gradient. Defaults to a dark-green gradient.
WidgetBuilder featureGraphicCanvas({
  DeviceInfo? device,
  required WidgetBuilder child,
  String? Function(BuildContext)? title,
  String? Function(BuildContext)? subtitle,
  Gradient? gradient,
}) {
  return (BuildContext context) {
    final titleText = title?.call(context);
    final subtitleText = subtitle?.call(context);
    final resolvedDevice = device ?? Devices.android.samsungGalaxyS25;

    return Container(
      decoration: BoxDecoration(gradient: gradient ?? _defaultGradient),
      child: Row(
        children: [
          // ── Left: marketing text ─────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleText != null)
                    Text(
                      titleText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                  if (subtitleText != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      subtitleText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── Right: device mockup ─────────────────────────────────────────
          SizedBox(
            width: 240,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: DeviceFrame(
                device: resolvedDevice,
                screen: ScreenshotContent(builder: child),
              ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  };
}
