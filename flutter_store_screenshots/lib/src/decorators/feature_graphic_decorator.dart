import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

import '../models/screenshot_set.dart';

/// Default gradient used by [featureGraphicDecorator] when no [gradient] is
/// provided.
const _defaultGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
);

/// Returns a [ScreenshotDecorator] for a **Google Play Feature Graphic**
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
/// - [device] — the [DeviceInfo] used for the right-side device mockup.
///   Defaults to `Devices.android.samsungGalaxyS25`.
/// - [gradient] — background gradient. Defaults to a dark-green gradient if
///   omitted.
///
/// The title and subtitle are sourced from each [StoreScreenshot]'s
/// `titleBuilder` / `subtitleBuilder` and are automatically passed in by the
/// framework — no extra wiring is required.
///
/// ## Example
/// ```dart
/// AndroidScreenshotSet.featureGraphic(
///   decorator: featureGraphicDecorator(
///     gradient: LinearGradient(
///       colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
///     ),
///   ),
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
ScreenshotDecorator featureGraphicDecorator({
  DeviceInfo? device,
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
                  if (title != null)
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      subtitle,
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
                screen: Builder(builder: contentBuilder),
              ),
            ),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  };
}
