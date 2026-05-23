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
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── Android Phone 6.7" ──────────────────────────────────────────────
        ScreenshotSet(
          name: 'Android Phone 6.7"',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── iOS iPad 12.9" ───────────────────────────────────────────────────
        ScreenshotSet(
          name: 'iOS iPad 12.9"',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(1024, 1366),
          pixelDensity: 2.0,
          storeScreenshots: _tabletScreenshots(),
        ),

        // ── Android Tablet 10.1" ─────────────────────────────────────────────
        ScreenshotSet(
          name: 'Android Tablet 10.1"',
          targetPlatform: TargetPlatform.android,
          size: const Size(800, 1280),
          pixelDensity: 2.0,
          storeScreenshots: _tabletScreenshots(),
        ),
      ],
    ),
  );
}

List<StoreScreenshot> _phoneScreenshots() => [
  StoreScreenshot(builder: (_) => const LoginScreen()),
  StoreScreenshot(builder: (_) => const HomeScreen()),
  StoreScreenshot(builder: (_) => const DetailScreen()),
  StoreScreenshot(builder: (_) => const SettingsScreen()),
];

List<StoreScreenshot> _tabletScreenshots() => [
  StoreScreenshot(builder: (_) => const HomeScreen()),
  StoreScreenshot(builder: (_) => const DetailScreen()),
  StoreScreenshot(builder: (_) => const SettingsScreen()),
];
