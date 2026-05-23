import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../models/screenshot_set.dart';
import '../models/store_screenshot.dart';
import '../widgets/store_screenshot.dart';

class FlutterStoreScreenshotsApp extends StatefulWidget {
  const FlutterStoreScreenshotsApp({
    super.key,
    required this.locales,
    required this.screenshotSets,
    this.localizationsDelegates,
    this.theme,
  });

  /// The locales the app supports. Feeds the locale selector dropdown.
  final List<Locale> locales;

  /// The sets of screenshots to preview. Feeds the set selector dropdown.
  final List<ScreenshotSet> screenshotSets;

  /// Optional localizations delegates from your app (e.g. generated ARB
  /// delegates). These are forwarded to [MaterialApp] so that
  /// [Localizations.override] inside each screenshot works correctly.
  final List<LocalizationsDelegate>? localizationsDelegates;

  /// App-level default theme applied to all screenshots unless overridden
  /// by a [ScreenshotSet] or individual [StoreScreenshot].
  final ThemeData? theme;

  @override
  State<FlutterStoreScreenshotsApp> createState() =>
      _FlutterStoreScreenshotsAppState();
}

class _FlutterStoreScreenshotsAppState
    extends State<FlutterStoreScreenshotsApp> {
  int _selectedLocaleIndex = 0;
  int _selectedSetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Store Screenshots',
      debugShowCheckedModeBanner: false,
      locale: widget.locales[_selectedLocaleIndex],
      supportedLocales: widget.locales,
      localizationsDelegates: [
        if (widget.localizationsDelegates != null)
          ...widget.localizationsDelegates!,
        ...GlobalMaterialLocalizations.delegates,
      ],
      home: _ScreenshotsHome(
        locales: widget.locales,
        screenshotSets: widget.screenshotSets,
        selectedLocaleIndex: _selectedLocaleIndex,
        selectedSetIndex: _selectedSetIndex,
        appTheme: widget.theme,
        onLocaleChanged: (i) => setState(() => _selectedLocaleIndex = i),
        onSetChanged: (i) => setState(() => _selectedSetIndex = i),
      ),
    );
  }
}

class _ScreenshotsHome extends StatelessWidget {
  const _ScreenshotsHome({
    required this.locales,
    required this.screenshotSets,
    required this.selectedLocaleIndex,
    required this.selectedSetIndex,
    required this.appTheme,
    required this.onLocaleChanged,
    required this.onSetChanged,
  });

  final List<Locale> locales;
  final List<ScreenshotSet> screenshotSets;
  final int selectedLocaleIndex;
  final int selectedSetIndex;
  final ThemeData? appTheme;
  final ValueChanged<int> onLocaleChanged;
  final ValueChanged<int> onSetChanged;

  @override
  Widget build(BuildContext context) {
    final set = screenshotSets[selectedSetIndex];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Flutter Store Screenshots'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedLocaleIndex,
                    items: [
                      for (int i = 0; i < locales.length; i++)
                        DropdownMenuItem(
                          value: i,
                          child: Text(locales[i].toLanguageTag()),
                        ),
                    ],
                    onChanged: (i) {
                      if (i != null) onLocaleChanged(i);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedSetIndex,
                    items: [
                      for (int i = 0; i < screenshotSets.length; i++)
                        DropdownMenuItem(
                          value: i,
                          child: Text(screenshotSets[i].name),
                        ),
                    ],
                    onChanged: (i) {
                      if (i != null) onSetChanged(i);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const padding = 24.0;
          const labelAreaHeight = 36.0; // SizedBox(8) + Text(~20) + margin
          final previewHeight =
              constraints.maxHeight - padding * 2 - labelAreaHeight;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final screenshot in set.storeScreenshots) ...[
                  _buildTile(
                    context,
                    screenshot,
                    set,
                    previewHeight: previewHeight,
                  ),
                  const SizedBox(width: 16),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    StoreScreenshot screenshot,
    ScreenshotSet set, {
    required double previewHeight,
  }) {
    final resolvedLocale =
        screenshot.locale ?? set.locale ?? locales[selectedLocaleIndex];
    final resolvedPlatform = screenshot.targetPlatform ?? set.targetPlatform;
    final resolvedSize = screenshot.size ?? set.size;
    assert(
      resolvedSize != null,
      'A size must be provided on the StoreScreenshot or its parent ScreenshotSet.',
    );
    final resolvedPixelDensity =
        screenshot.pixelDensity ?? set.pixelDensity ?? 1.0;
    final resolvedTheme = screenshot.theme ?? set.theme ?? appTheme;

    final previewWidth =
        previewHeight * (resolvedSize!.width / resolvedSize.height);

    // Bind the set-level decorator with this screenshot's title/subtitle so
    // ScreenshotRender only needs a simple (BuildContext, WidgetBuilder) fn.
    final rawDecorator = set.decorator;
    final boundDecorator = rawDecorator == null
        ? null
        : (BuildContext ctx, WidgetBuilder cb) =>
              rawDecorator(ctx, cb, screenshot.title, screenshot.subtitle);

    return Column(
      children: [
        SizedBox(
          width: previewWidth,
          height: previewHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            child: ScreenshotRender(
              locale: resolvedLocale,
              platform: resolvedPlatform,
              theme: resolvedTheme,
              size: resolvedSize,
              pixelDensity: resolvedPixelDensity,
              builder: screenshot.builder,
              decorator: boundDecorator,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${resolvedSize.width.toInt()} × ${resolvedSize.height.toInt()}  •  ${set.name}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
