import 'package:flutter/material.dart';

/// A widget that renders an isolated app screen inside a screenshot canvas.
///
/// Place one or more [ScreenshotContent] instances anywhere inside a
/// [StoreScreenshot.builder] to embed app screens in the canvas. Each instance
/// is wrapped in a fresh [Navigator] by default so the screen always appears
/// as the root route (no back button in the [AppBar]).
///
/// For device-framed content, wrap this widget in a [DeviceFrame] from the
/// `device_frame` package — it will inject the correct device-level
/// [MediaQuery] for its content:
///
/// ```dart
/// DeviceFrame(
///   device: Devices.ios.iPhone16ProMax,
///   screen: ScreenshotContent(builder: (_) => HomeScreen()),
/// )
/// ```
///
/// For a bare screenshot (no device frame, filling the canvas), use
/// [ScreenshotContent] directly without a [DeviceFrame].
class ScreenshotContent extends StatelessWidget {
  const ScreenshotContent({
    super.key,
    required this.builder,
    this.showBackButton = false,
  });

  /// Builder for the app screen widget.
  final WidgetBuilder builder;

  /// Whether to allow the rendered screen to show a back button.
  ///
  /// By default (`false`) the content is wrapped in a fresh [Navigator] so
  /// the screen always appears as the root route — no back button is shown
  /// in an [AppBar], regardless of the surrounding navigation stack.
  ///
  /// Set to `true` when you intentionally want to capture a screen that
  /// has a back button (e.g. a detail page that should show the ← icon).
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    if (showBackButton) {
      return Builder(builder: builder);
    }
    return Navigator(
      onGenerateRoute: (settings) => PageRouteBuilder<void>(
        settings: settings,
        pageBuilder: (c, a1, a2) => Builder(builder: builder),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
