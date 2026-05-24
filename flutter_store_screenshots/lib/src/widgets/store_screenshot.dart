import 'package:flutter/material.dart';

/// Internal widget that renders a single screenshot with fully resolved
/// configuration values.
class ScreenshotRender extends StatelessWidget {
  const ScreenshotRender({
    super.key,
    required this.locale,
    this.platform,
    this.theme,
    required this.size,
    required this.pixelDensity,
    required this.builder,
  });

  final Locale locale;
  final TargetPlatform? platform;
  final ThemeData? theme;
  final Size size;
  final double pixelDensity;

  /// Builder for the full screenshot canvas. The [BuildContext] provided has
  /// the correct [Theme], [Localizations], and [MediaQuery] (canvas size)
  /// already set up. Use [ScreenshotContent] inside this builder to embed
  /// isolated app screens.
  final WidgetBuilder builder;

  ThemeData _resolveTheme() {
    if (theme != null && platform != null) {
      return theme!.copyWith(platform: platform);
    } else if (theme != null) {
      return theme!;
    } else if (platform != null) {
      return ThemeData(platform: platform);
    }
    return ThemeData.fallback();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _resolveTheme(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          size: size,
          devicePixelRatio: pixelDensity,
          // Zero out host-app insets so the screenshot renders in isolation,
          // as it would on the target device.
          padding: EdgeInsets.zero,
          viewPadding: EdgeInsets.zero,
          viewInsets: EdgeInsets.zero,
          systemGestureInsets: EdgeInsets.zero,
        ),
        child: Localizations.override(
          context: context,
          locale: locale,
          child: IgnorePointer(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Builder(builder: builder),
            ),
          ),
        ),
      ),
    );
  }
}
