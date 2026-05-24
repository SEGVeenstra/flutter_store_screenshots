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

        // ── RAW: no decorator (bare captures) ─────────────────────────────────
        // Using ScreenshotSet directly without any preset subclass or decorator.
        // The app content is rendered as-is at the given canvas size — useful
        // for plain screenshots or when you supply your own post-processing.
        ScreenshotSet(
          name: 'Raw Bare Screenshots',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── RAW: fully custom inline decorator ────────────────────────────────
        // ScreenshotDecorator is just a function — you can write any layout
        // you like without using framedDecorator or featureGraphicDecorator.
        // Here the app content is clipped to a rounded rectangle and placed
        // on a solid coral background.
        ScreenshotSet(
          name: 'Raw Custom Decorator',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          decorator: (context, contentBuilder, titleBuilder, subtitleBuilder) {
            final title = titleBuilder?.call(context);
            final subtitle = subtitleBuilder?.call(context);
            return ColoredBox(
              color: const Color(0xFFBF360C),
              child: Column(
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 56, 32, 0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Builder(builder: contentBuilder),
                      ),
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
          storeScreenshots: _phoneScreenshots(),
        ),

        // ── Per-screenshot theme override (dark mode) ──────────────────────────
        // Individual StoreScreenshots can override the theme independently of
        // the set- or app-level theme. Here every screenshot is rendered in
        // dark mode while still using the shared framedDecorator.
        ScreenshotSet(
          name: 'Dark Theme Overrides',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
          decorator: framedDecorator(
            device: Devices.android.samsungGalaxyS25,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF212121), Color(0xFF616161)],
            ),
          ),
          storeScreenshots: [
            StoreScreenshot(
              name: 'home_dark',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF6C63FF),
                  brightness: Brightness.dark,
                ),
              ),
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotHomeTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotHomeSubtitle,
              builder: (_) => const HomeScreen(),
            ),
            StoreScreenshot(
              name: 'detail_dark',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF6C63FF),
                  brightness: Brightness.dark,
                ),
              ),
              // showBackButton: true lets the AppBar back arrow appear,
              // making the detail screenshot look like a real navigation flow.
              showBackButton: true,
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotDetailTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotDetailSubtitle,
              builder: (_) => const DetailScreen(),
            ),
            StoreScreenshot(
              name: 'settings_dark',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF6C63FF),
                  brightness: Brightness.dark,
                ),
              ),
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotSettingsTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotSettingsSubtitle,
              builder: (_) => const SettingsScreen(),
            ),
          ],
        ),

        // ── Per-screenshot locale & showBackButton ─────────────────────────────
        // Each StoreScreenshot can pin its own locale, overriding both the
        // set-level and app-level locale selection. Combine with showBackButton
        // and captureDelay to show exactly the UI state you want per slide.
        ScreenshotSet(
          name: 'Pinned Locales + Back Button',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          decorator: framedDecorator(
            device: Devices.ios.iPhone16ProMax,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF880E4F), Color(0xFFEC407A)],
            ),
          ),
          storeScreenshots: [
            // English — root screen, no back button (default behaviour)
            StoreScreenshot(
              name: 'home_en',
              locale: const Locale('en'),
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotHomeTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotHomeSubtitle,
              builder: (_) => const HomeScreen(),
            ),
            // Dutch — detail screen with back button visible
            StoreScreenshot(
              name: 'detail_nl',
              locale: const Locale('nl'),
              showBackButton: true,
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotDetailTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotDetailSubtitle,
              builder: (_) => const DetailScreen(),
            ),
            // Spanish — settings screen
            StoreScreenshot(
              name: 'settings_es',
              locale: const Locale('es'),
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotSettingsTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotSettingsSubtitle,
              builder: (_) => const SettingsScreen(),
            ),
            // German — with a per-screenshot captureDelay to let any
            // animations or image fade-ins finish before capture.
            StoreScreenshot(
              name: 'login_de',
              locale: const Locale('de'),
              captureDelay: const Duration(seconds: 1),
              titleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotLoginTitle,
              subtitleBuilder: (ctx) =>
                  AppLocalizations.of(ctx).screenshotLoginSubtitle,
              builder: (_) => const LoginScreen(),
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
