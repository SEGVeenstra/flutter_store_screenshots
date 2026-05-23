import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';

import 'app_screens/detail_screen.dart';
import 'app_screens/home_screen.dart';
import 'app_screens/login_screen.dart';
import 'app_screens/settings_screen.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    FlutterStoreScreenshotsApp(
      // ── Supported locales ──────────────────────────────────────────────────
      locales: const [Locale('en'), Locale('nl'), Locale('es'), Locale('de')],
      localizationsDelegates: const [AppLocalizations.delegate],

      // ── App-level theme ────────────────────────────────────────────────────
      theme: AppTheme.light,

      // ── Screenshot sets ────────────────────────────────────────────────────
      screenshotSets: [
        // ── iOS Phone 6.7" ──────────────────────────────────────────────────
        ScreenshotSet(
          name: 'iOS Phone 6.7"',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          decorator: (ctx, builder, title, subtitle) => _framedDecorator(
            ctx,
            builder,
            title,
            subtitle,
            device: Devices.ios.iPhone16ProMax,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A237E), Color(0xFF7986CB)],
            ),
          ),
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── Android Phone 6.7" ──────────────────────────────────────────────
        ScreenshotSet(
          name: 'Android Phone 6.7"',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
          decorator: (ctx, builder, title, subtitle) => _framedDecorator(
            ctx,
            builder,
            title,
            subtitle,
            device: Devices.android.samsungGalaxyS25,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
            ),
          ),
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── iOS iPad 12.9" ───────────────────────────────────────────────────
        ScreenshotSet(
          name: 'iOS iPad 12.9"',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(1024, 1366),
          pixelDensity: 2.0,
          decorator: (ctx, builder, title, subtitle) => _framedDecorator(
            ctx,
            builder,
            title,
            subtitle,
            device: Devices.ios.iPad12InchesGen4,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A148C), Color(0xFFBA68C8)],
            ),
          ),
          storeScreenshots: _tabletScreenshots(),
        ),

        // ── Android Tablet 10.1" ─────────────────────────────────────────────
        ScreenshotSet(
          name: 'Android Tablet 10.1"',
          targetPlatform: TargetPlatform.android,
          size: const Size(800, 1280),
          pixelDensity: 2.0,
          decorator: (ctx, builder, title, subtitle) => _framedDecorator(
            ctx,
            builder,
            title,
            subtitle,
            device: Devices.android.largeTablet,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            ),
          ),
          storeScreenshots: _tabletScreenshots(),
        ),
      ],
    ),
  );
}

/// Renders a store-screenshot canvas with a gradient background, a marketing
/// [title] at the top, a [DeviceFrame] containing the app content, and an
/// optional [subtitle] at the bottom.
///
/// The [DeviceFrame] widget injects the correct inner [MediaQuery] for the
/// app screen, so the app content sees the right screen dimensions.
Widget _framedDecorator(
  BuildContext context,
  WidgetBuilder contentBuilder,
  String? title,
  String? subtitle, {
  required DeviceInfo device,
  required Gradient gradient,
}) {
  return Container(
    decoration: BoxDecoration(gradient: gradient),
    child: Column(
      children: [
        // ── Title ────────────────────────────────────────────────────────────
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

        // ── Device frame ─────────────────────────────────────────────────────
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: DeviceFrame(
              device: device,
              // Builder(builder: contentBuilder) lets DeviceFrame inject
              // the correct inner MediaQuery before calling contentBuilder.
              screen: Builder(builder: contentBuilder),
            ),
          ),
        ),

        // ── Subtitle ─────────────────────────────────────────────────────────
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
}

List<StoreScreenshot> _phoneScreenshots() => [
  StoreScreenshot(
    title: 'Sign in securely',
    subtitle: 'One tap and you\'re in.',
    builder: (_) => const LoginScreen(),
  ),
  StoreScreenshot(
    title: 'Everything at a glance',
    subtitle: 'Your home screen, simplified.',
    builder: (_) => const HomeScreen(),
  ),
  StoreScreenshot(
    title: 'Dive into the details',
    subtitle: 'All the info you need, beautifully laid out.',
    builder: (_) => const DetailScreen(),
  ),
  StoreScreenshot(
    title: 'Your app, your way',
    subtitle: 'Customise everything to fit your life.',
    builder: (_) => const SettingsScreen(),
  ),
];

List<StoreScreenshot> _tabletScreenshots() => [
  StoreScreenshot(
    title: 'Sign in securely',
    subtitle: 'One tap and you\'re in.',
    builder: (_) => const LoginScreen(),
  ),
  StoreScreenshot(
    title: 'Everything at a glance',
    subtitle: 'Your home screen, simplified.',
    builder: (_) => const HomeScreen(),
  ),
  StoreScreenshot(
    title: 'Dive into the details',
    subtitle: 'All the info you need, beautifully laid out.',
    builder: (_) => const DetailScreen(),
  ),
  StoreScreenshot(
    title: 'Your app, your way',
    subtitle: 'Customise everything to fit your life.',
    builder: (_) => const SettingsScreen(),
  ),
];
