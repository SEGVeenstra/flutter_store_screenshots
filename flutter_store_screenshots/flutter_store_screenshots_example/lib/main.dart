import 'package:flutter/material.dart';
import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';
import 'package:flutter_store_screenshots_example/app_screens/login_screen.dart';

void main() {
  runApp(
    FlutterStoreScreenshotsApp(
      locales: const [Locale('en', 'US'), Locale('nl', 'NL')],
      screenshotSets: [
        ScreenshotSet(
          name: 'iOS Phone (6.7")',
          targetPlatform: TargetPlatform.iOS,
          size: const Size(430, 932),
          pixelDensity: 3.0,
          storeScreenshots: [
            StoreScreenshot(builder: (context) => const LoginScreen()),
          ],
        ),
        ScreenshotSet(
          name: 'Android Phone (6.7")',
          targetPlatform: TargetPlatform.android,
          size: const Size(412, 892),
          pixelDensity: 2.625,
          storeScreenshots: [
            StoreScreenshot(builder: (context) => const LoginScreen()),
          ],
        ),
      ],
    ),
  );
}
