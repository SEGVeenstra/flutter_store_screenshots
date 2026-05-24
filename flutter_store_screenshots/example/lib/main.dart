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
        // ── iOS Phone 6.7" — framedCanvas (single device, title + subtitle) ──
        //
        // framedCanvas returns a WidgetBuilder used directly as
        // StoreScreenshot.builder. Title and subtitle call AppLocalizations
        // directly on the BuildContext, which already has the right locale.
        AppleScreenshotSet.iPhone67(
          storeScreenshots: _phoneScreenshots(
            device: Devices.ios.iPhone16ProMax,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A237E), Color(0xFF7986CB)],
            ),
          ),
        ),

        // ── Android Phone ────────────────────────────────────────────────────
        AndroidScreenshotSet.phone(
          storeScreenshots: _phoneScreenshots(
            device: Devices.android.samsungGalaxyS25,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B5E20), Color(0xFF66BB6A)],
            ),
          ),
        ),

        // ── iOS iPad Pro 12.9" ───────────────────────────────────────────────
        AppleScreenshotSet.iPadPro129(
          storeScreenshots: _tabletScreenshots(
            device: Devices.ios.iPad12InchesGen4,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A148C), Color(0xFFBA68C8)],
            ),
          ),
        ),

        // ── Android Tablet 7" ────────────────────────────────────────────────
        AndroidScreenshotSet.tablet7(
          storeScreenshots: _tabletScreenshots(
            device: Devices.android.mediumTablet,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF006064), Color(0xFF4DD0E1)],
            ),
          ),
        ),

        // ── Android Tablet 10" ───────────────────────────────────────────────
        AndroidScreenshotSet.tablet10(
          storeScreenshots: _tabletScreenshots(
            device: Devices.android.largeTablet,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            ),
          ),
        ),

        // ── Google Play Feature Graphic ──────────────────────────────────────
        //
        // featureGraphicCanvas returns a WidgetBuilder with marketing text on
        // the left and a device mockup on the right.
        AndroidScreenshotSet.featureGraphic(
          storeScreenshots: [
            StoreScreenshot(
              name: 'feature_graphic',
              builder: featureGraphicCanvas(
                child: (_) => const HomeScreen(),
                title: (ctx) => AppLocalizations.of(ctx).appName,
                subtitle: (ctx) =>
                    AppLocalizations.of(ctx).screenshotFeatureTitle,
              ),
            ),
          ],
        ),

        // ── Multi-device canvas ───────────────────────────────────────────────
        //
        // A single StoreScreenshot.builder can place multiple ScreenshotContent
        // widgets — each independently isolated and device-framed — anywhere in
        // the canvas. This achieves the banner-style layout where several phones
        // appear side-by-side on one image.
        //
        // Wrap each ScreenshotContent in a DeviceFrame to inject the correct
        // device-level MediaQuery for that screen.
        ScreenshotSet(
          name: 'Multi-Device Banner',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(1290, 2796),
          pixelDensity: 1.0,
          storeScreenshots: [
            StoreScreenshot(
              name: 'multi_device',
              builder: (context) {
                final loc = AppLocalizations.of(context);
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    ),
                  ),
                  child: Column(
                    children: [
                      // ── Marketing headline ─────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 120, 80, 0),
                        child: Text(
                          loc.screenshotHomeTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 32, 80, 0),
                        child: Text(
                          loc.screenshotHomeSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 44,
                            height: 1.4,
                          ),
                        ),
                      ),

                      // ── Three phones side-by-side ──────────────────────────
                      //
                      // Each DeviceFrame injects the phone's viewport MediaQuery
                      // for its ScreenshotContent. showBackButton: true on the
                      // detail screen makes the ← icon visible.
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 60,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: DeviceFrame(
                                    device: Devices.ios.iPhone16ProMax,
                                    screen: ScreenshotContent(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: DeviceFrame(
                                  device: Devices.ios.iPhone16ProMax,
                                  screen: ScreenshotContent(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 60),
                                  child: DeviceFrame(
                                    device: Devices.ios.iPhone16ProMax,
                                    screen: ScreenshotContent(
                                      showBackButton: true,
                                      builder: (_) => const DetailScreen(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),

        // ── Fully custom canvas — no helper functions ─────────────────────────
        //
        // StoreScreenshot.builder owns the entire canvas. AppLocalizations,
        // theming, and device framing are all handled directly in the builder.
        // ScreenshotContent provides Navigator isolation without any device
        // frame — the app content fills the space its parent gives it.
        ScreenshotSet(
          name: 'Custom Canvas',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          storeScreenshots: [
            StoreScreenshot(
              name: 'custom_home',
              builder: (context) {
                final loc = AppLocalizations.of(context);
                return ColoredBox(
                  color: const Color(0xFFBF360C),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 56, 32, 0),
                        child: Text(
                          loc.screenshotHomeTitle,
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
                            // Bare ScreenshotContent (no DeviceFrame) — fills
                            // whatever space its parent provides.
                            child: ScreenshotContent(
                              builder: (_) => const HomeScreen(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
                        child: Text(
                          loc.screenshotHomeSubtitle,
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
            ),
          ],
        ),

        // ── Per-screenshot theme override (dark mode) ─────────────────────────
        //
        // Individual StoreScreenshots can still override theme, locale, size,
        // and pixelDensity independently of the set-level defaults.
        ScreenshotSet(
          name: 'Dark Theme',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
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
              builder: framedCanvas(
                device: Devices.android.samsungGalaxyS25,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF212121), Color(0xFF616161)],
                ),
                child: (_) => const HomeScreen(),
                title: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
                subtitle: (ctx) =>
                    AppLocalizations.of(ctx).screenshotHomeSubtitle,
              ),
            ),
            // showBackButton is controlled via ScreenshotContent — use a custom
            // builder when you need the ← icon to appear on a detail screen.
            StoreScreenshot(
              name: 'detail_dark',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF6C63FF),
                  brightness: Brightness.dark,
                ),
              ),
              builder: (context) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF212121), Color(0xFF616161)],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                      child: Text(
                        AppLocalizations.of(context).screenshotDetailTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        child: DeviceFrame(
                          device: Devices.android.samsungGalaxyS25,
                          screen: ScreenshotContent(
                            showBackButton: true,
                            builder: (_) => const DetailScreen(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                      child: Text(
                        AppLocalizations.of(context).screenshotDetailSubtitle,
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
              ),
            ),
          ],
        ),

        // ── Panoramic canvas — fan of phones ─────────────────────────────────
        //
        // Three phones arranged like a hand of cards spread across 3 screenshots.
        //
        //   screenshot 0     │  screenshot 1   │  screenshot 2
        //   ─────────────────┼─────────────────┼─────────────────
        //                 ╱──┼──╲           ╱──┼──╲
        //              ╱ left ╲ │        ╱right╲  │
        //           ╱  (Login) ╲│      ╱(Settings)╲
        //                       │  ┌─────────┐    │
        //                       │  │ center  │    │
        //                       │  │ (Home)  │    │
        //                       │  └─────────┘    │
        //
        // • Left phone   — centred on the 0→1 boundary, rotated −17°.
        //   Half visible in screenshot 0, half in screenshot 1.
        // • Right phone  — centred on the 1→2 boundary, rotated +17°.
        //   Half visible in screenshot 1, half in screenshot 2.
        // • Center phone — centred in slice 1, upright, painted last (on top).
        //   The rotation of the side phones makes their visual footprint even
        //   wider, so they bleed further into the adjacent screenshot than the
        //   layout box alone suggests.
        AppleScreenshotSet.iPhone67(
          storeScreenshots: panoramicCanvas(
            count: 3,
            names: ['panoramic_login', 'panoramic_home', 'panoramic_settings'],
            panoramaBuilder: (context) {
              // MediaQuery.sizeOf returns the full panorama size here:
              //   width  = 3 × 430 = 1290 logical px
              //   height = 932 logical px
              final size = MediaQuery.sizeOf(context);
              final sliceW = size.width / 3;
              final loc = AppLocalizations.of(context);

              // Center phone: largest, upright, prominent.
              final centerH = size.height * 0.78;
              final centerW = centerH * 0.48;

              // Side phones: slightly smaller, rotated outward to create depth.
              final sideH = size.height * 0.64;
              final sideW = sideH * 0.48;

              // Side phones sit higher on the canvas; center phone sits lower.
              // This vertical stagger reinforces the fan / depth illusion.
              final sideCy = size.height * 0.42;
              final centerCy = size.height * 0.56;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // ── Seamless gradient across the full panorama ──────────────
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1A237E),
                          Color(0xFF1565C0),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),

                  // ── Title per slice ─────────────────────────────────────────
                  for (final (i, title) in [
                    (0, loc.screenshotLoginTitle),
                    (1, loc.screenshotHomeTitle),
                    (2, loc.screenshotSettingsTitle),
                  ])
                    Positioned(
                      left: i * sliceW + 28,
                      width: sliceW - 56,
                      top: 72,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ),

                  // ── Left phone: Login, straddles 0→1 boundary ──────────────
                  // Painted first → behind both other phones in z-order.
                  Positioned(
                    left: sliceW - sideW / 2,
                    top: sideCy - sideH / 2,
                    width: sideW,
                    height: sideH,
                    child: Transform.rotate(
                      angle: -0.30, // ≈ −17°
                      child: DeviceFrame(
                        device: Devices.ios.iPhone16ProMax,
                        screen: ScreenshotContent(
                          builder: (_) => const LoginScreen(),
                        ),
                      ),
                    ),
                  ),

                  // ── Right phone: Settings, straddles 1→2 boundary ──────────
                  // Painted second → behind center phone.
                  Positioned(
                    left: 2 * sliceW - sideW / 2,
                    top: sideCy - sideH / 2,
                    width: sideW,
                    height: sideH,
                    child: Transform.rotate(
                      angle: 0.30, // ≈ +17°
                      child: DeviceFrame(
                        device: Devices.ios.iPhone16ProMax,
                        screen: ScreenshotContent(
                          builder: (_) => const SettingsScreen(),
                        ),
                      ),
                    ),
                  ),

                  // ── Center phone: Home, centered in slice 1 ────────────────
                  // Painted last → on top of both side phones.
                  Positioned(
                    left: size.width / 2 - centerW / 2,
                    top: centerCy - centerH / 2,
                    width: centerW,
                    height: centerH,
                    child: DeviceFrame(
                      device: Devices.ios.iPhone16ProMax,
                      screen: ScreenshotContent(
                        builder: (_) => const HomeScreen(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // ── Per-screenshot pinned locales ─────────────────────────────────────
        //
        // Each StoreScreenshot can pin its own locale. The BuildContext passed
        // to the builder already has that locale active, so AppLocalizations
        // returns the correct language automatically.
        ScreenshotSet(
          name: 'Pinned Locales',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          storeScreenshots: [
            StoreScreenshot(
              name: 'home_en',
              locale: const Locale('en'),
              builder: framedCanvas(
                device: Devices.ios.iPhone16ProMax,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF880E4F), Color(0xFFEC407A)],
                ),
                child: (_) => const HomeScreen(),
                title: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
                subtitle: (ctx) =>
                    AppLocalizations.of(ctx).screenshotHomeSubtitle,
              ),
            ),
            StoreScreenshot(
              name: 'detail_nl',
              locale: const Locale('nl'),
              builder: framedCanvas(
                device: Devices.ios.iPhone16ProMax,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF880E4F), Color(0xFFEC407A)],
                ),
                child: (_) => const DetailScreen(),
                title: (ctx) => AppLocalizations.of(ctx).screenshotDetailTitle,
                subtitle: (ctx) =>
                    AppLocalizations.of(ctx).screenshotDetailSubtitle,
              ),
            ),
            StoreScreenshot(
              name: 'login_de',
              locale: const Locale('de'),
              captureDelay: const Duration(seconds: 1),
              builder: framedCanvas(
                device: Devices.ios.iPhone16ProMax,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF880E4F), Color(0xFFEC407A)],
                ),
                child: (_) => const LoginScreen(),
                title: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
                subtitle: (ctx) =>
                    AppLocalizations.of(ctx).screenshotLoginSubtitle,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ── Helpers ───────────────────────────────────────────────────────────────────
//
// Define your own helper functions to avoid repeating framedCanvas arguments
// across screenshots in a set. This is the idiomatic Dart replacement for the
// old set-level `decorator` parameter.

List<StoreScreenshot> _phoneScreenshots({
  required DeviceInfo device,
  required Gradient gradient,
}) => [
  StoreScreenshot(
    name: 'login',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const LoginScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotLoginSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'home',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const HomeScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'detail',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const DetailScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotDetailTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotDetailSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'settings',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const SettingsScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotSettingsTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotSettingsSubtitle,
    ),
  ),
];

List<StoreScreenshot> _tabletScreenshots({
  required DeviceInfo device,
  required Gradient gradient,
}) => [
  StoreScreenshot(
    name: 'login',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const LoginScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotLoginTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotLoginSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'home',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const HomeScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotHomeTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotHomeSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'detail',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const DetailScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotDetailTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotDetailSubtitle,
    ),
  ),
  StoreScreenshot(
    name: 'settings',
    builder: framedCanvas(
      device: device,
      gradient: gradient,
      child: (_) => const SettingsScreen(),
      title: (ctx) => AppLocalizations.of(ctx).screenshotSettingsTitle,
      subtitle: (ctx) => AppLocalizations.of(ctx).screenshotSettingsSubtitle,
    ),
  ),
];
