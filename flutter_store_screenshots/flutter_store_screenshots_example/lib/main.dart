import 'package:flutter/material.dart';
import 'package:flutter_store_screenshots/flutter_store_screenshots.dart';
import 'package:flutter_store_screenshots_example/app_screens/login_screen.dart';

void main() {
  runApp(
    FlutterStoreScreenshotsApp(
      screenshots: [
        StoreScreenshot(
          size: Size(400, 800),
          locale: Locale('en', 'US'),
          builder: (context) => const LoginScreen(),
          platform: TargetPlatform.iOS,
        ),
        StoreScreenshot(
          size: Size(360, 720),
          locale: Locale('en', 'US'),
          builder: (context) => const LoginScreen(),
          platform: TargetPlatform.android,
        ),
      ],
    ),
  );
}
