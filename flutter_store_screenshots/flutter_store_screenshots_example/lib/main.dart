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
        AppleScreenshotSet.iPhone67(
          decorator: framedDecorator(
            device: Devices.ios.iPhone16ProMax,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A237E), Color(0xFF7986CB)],
            ),
          ),
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── Android Phone ────────────────────────────────────────────────────
        AndroidScreenshotSet.phone(
          decorator: framedDecorator(
            device: Devices.android.samsungGalaxyS25,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
            ),
          ),
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── iOS iPad Pro 12.9" ───────────────────────────────────────────────
        AppleScreenshotSet.iPadPro129(
          decorator: framedDecorator(
            device: Devices.ios.iPad12InchesGen4,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A148C), Color(0xFFBA68C8)],
            ),
          ),
          storeScreenshots: _tabletScreenshots(),
        ),

        // ── Android Tablet 7" ────────────────────────────────────────────────
        AndroidScreenshotSet.tablet7(
          decorator: framedDecorator(
            device: Devices.android.mediumTablet,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF006064), Color(0xFF4DD0E1)],
            ),
          ),
          storeScreenshots: _tabletScreenshots(),
        ),

        // ── Android Tablet 10" ───────────────────────────────────────────────
        AndroidScreenshotSet.tablet10(
          decorator: framedDecorator(
            device: Devices.android.largeTablet,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            ),
          ),
          storeScreenshots: _tabletScreenshots(),
        ),

        // ── Google Play Feature Graphic ──────────────────────────────────────
        AndroidScreenshotSet.featureGraphic(
          decorator: featureGraphicDecorator(),
          storeScreenshots: [
            StoreScreenshot(
              name: 'feature_graphic',
              titleBuilder: (ctx) => AppLocalizations.of(ctx).appName,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotFeatureTitle,
              builder: (_) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  );
}

List<StoreScreenshot> _phoneScreenshots() => [
  StoreScreenshot(
    name: 'login',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginSubtitle,
    builder: (_) => const LoginScreen(),
  ),
  StoreScreenshot(
    name: 'home',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
    builder: (_) => const HomeScreen(),
  ),
  StoreScreenshot(
    name: 'detail',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotDetailTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotDetailSubtitle,
    builder: (_) => const DetailScreen(),
  ),
  StoreScreenshot(
    name: 'settings',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotSettingsTitle,
    subtitleBuilder: (ctx) =>
        AppLocalizations.of(ctx).screenshotSettingsSubtitle,
    builder: (_) => const SettingsScreen(),
  ),
];

List<StoreScreenshot> _tabletScreenshots() => [
  StoreScreenshot(
    name: 'login',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotLoginSubtitle,
    builder: (_) => const LoginScreen(),
  ),
  StoreScreenshot(
    name: 'home',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
    builder: (_) => const HomeScreen(),
  ),
  StoreScreenshot(
    name: 'detail',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotDetailTitle,
    subtitleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotDetailSubtitle,
    builder: (_) => const DetailScreen(),
  ),
  StoreScreenshot(
    name: 'settings',
    titleBuilder: (ctx) => AppLocalizations.of(ctx).screenshotSettingsTitle,
    subtitleBuilder: (ctx) =>
        AppLocalizations.of(ctx).screenshotSettingsSubtitle,
    builder: (_) => const SettingsScreen(),
  ),
];
