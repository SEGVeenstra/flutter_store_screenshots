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
    this.decorator,
    this.showBackButton = false,
  });

  final Locale locale;
  final TargetPlatform? platform;
  final ThemeData? theme;
  final Size size;
  final double pixelDensity;
  final WidgetBuilder builder;

  /// Optional bound decorator — already has title/subtitle closed over.
  /// When present, the decorator is responsible for the canvas layout and
  /// for placing [builder] inside a frame that injects the correct inner
  /// [MediaQuery]. The canvas-level [MediaQuery] (size = [size]) is still
  /// applied before calling the decorator.
  final Widget Function(BuildContext, WidgetBuilder)? decorator;

  /// When false (the default), the content builder is wrapped in a fresh
  /// [Navigator] so the screen always renders as the root route — preventing
  /// unexpected back buttons in [AppBar] widgets.
  ///
  /// Set to true to opt out of the isolation and allow back buttons to appear
  /// (e.g. when you intentionally capture a screen with a ← icon).
  final bool showBackButton;

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
    // When showBackButton is false, wrap the content in a fresh Navigator so
    // the screen is always the root route and AppBar never shows a back button.
    final isolatedBuilder = showBackButton
        ? builder
        : (BuildContext ctx) => Navigator(
            onGenerateRoute: (settings) => PageRouteBuilder<void>(
              settings: settings,
              pageBuilder: (c, _, __) => Builder(builder: builder),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );

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
              child: decorator != null
                  ? Builder(builder: (ctx) => decorator!(ctx, isolatedBuilder))
                  : Builder(builder: isolatedBuilder),
            ),
          ),
        ),
      ),
    );
  }
}
