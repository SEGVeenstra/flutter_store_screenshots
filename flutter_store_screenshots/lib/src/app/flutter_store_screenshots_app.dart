import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        localizationsDelegates: widget.localizationsDelegates,
        onLocaleChanged: (i) => setState(() => _selectedLocaleIndex = i),
        onSetChanged: (i) => setState(() => _selectedSetIndex = i),
      ),
    );
  }
}

class _ScreenshotsHome extends StatefulWidget {
  const _ScreenshotsHome({
    required this.locales,
    required this.screenshotSets,
    required this.selectedLocaleIndex,
    required this.selectedSetIndex,
    required this.appTheme,
    this.localizationsDelegates,
    required this.onLocaleChanged,
    required this.onSetChanged,
  });

  final List<Locale> locales;
  final List<ScreenshotSet> screenshotSets;
  final int selectedLocaleIndex;
  final int selectedSetIndex;
  final ThemeData? appTheme;
  final List<LocalizationsDelegate>? localizationsDelegates;
  final ValueChanged<int> onLocaleChanged;
  final ValueChanged<int> onSetChanged;

  @override
  State<_ScreenshotsHome> createState() => _ScreenshotsHomeState();
}

class _ScreenshotsHomeState extends State<_ScreenshotsHome> {
  bool _screenshotsDirExists = false;

  String get _outputBase =>
      '${Directory.current.path}${Platform.pathSeparator}screenshots';

  @override
  void initState() {
    super.initState();
    _checkScreenshotsDirExists();
  }

  Future<void> _checkScreenshotsDirExists() async {
    final exists = await Directory(_outputBase).exists();
    if (mounted) setState(() => _screenshotsDirExists = exists);
  }

  Future<void> _openScreenshotsFolder() async {
    await Process.run('open', [_outputBase]);
  }

  @override
  Widget build(BuildContext context) {
    final set = widget.screenshotSets[widget.selectedSetIndex];
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
                    value: widget.selectedLocaleIndex,
                    items: [
                      for (int i = 0; i < widget.locales.length; i++)
                        DropdownMenuItem(
                          value: i,
                          child: Text(widget.locales[i].toLanguageTag()),
                        ),
                    ],
                    onChanged: (i) {
                      if (i != null) widget.onLocaleChanged(i);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: widget.selectedSetIndex,
                    items: [
                      for (int i = 0; i < widget.screenshotSets.length; i++)
                        DropdownMenuItem(
                          value: i,
                          child: Text(widget.screenshotSets[i].name),
                        ),
                    ],
                    onChanged: (i) {
                      if (i != null) widget.onSetChanged(i);
                    },
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.folder_open_outlined),
                  tooltip: 'Open screenshots folder in Finder',
                  onPressed: _screenshotsDirExists
                      ? _openScreenshotsFolder
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.file_download_outlined),
                  tooltip: 'Export all screenshots',
                  onPressed: () => _exportAll(context),
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
        screenshot.locale ??
        set.locale ??
        widget.locales[widget.selectedLocaleIndex];
    final resolvedPlatform = screenshot.targetPlatform ?? set.targetPlatform;
    final resolvedSize = screenshot.size ?? set.size;
    assert(
      resolvedSize != null,
      'A size must be provided on the StoreScreenshot or its parent ScreenshotSet.',
    );
    final resolvedPixelDensity =
        screenshot.pixelDensity ?? set.pixelDensity ?? 1.0;
    final resolvedTheme = screenshot.theme ?? set.theme ?? widget.appTheme;

    final previewWidth =
        previewHeight * (resolvedSize!.width / resolvedSize.height);

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

  Future<void> _exportAll(BuildContext context) async {
    final total =
        widget.locales.length *
        widget.screenshotSets.fold<int>(
          0,
          (sum, set) => sum + set.storeScreenshots.length,
        );
    var done = 0;

    if (!context.mounted) return;

    // Mutable capture state — updated before each screenshot render.
    var captureLocale = widget.locales.first;
    var captureSize =
        (widget.screenshotSets.first.storeScreenshots.first.size ??
        widget.screenshotSets.first.size)!;
    var capturePixelDensity = 1.0;
    TargetPlatform? capturePlatform;
    ThemeData? captureTheme;
    WidgetBuilder captureBuilder =
        widget.screenshotSets.first.storeScreenshots.first.builder;

    final captureKey = GlobalKey();
    final progressNotifier = ValueNotifier<String>('0 / $total');
    // Hook assigned by the StatefulBuilder so we can trigger dialog rebuilds.
    late void Function(void Function()) setDialogState;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) {
          setDialogState = setState;
          return AlertDialog(
            title: const Text('Exporting screenshots'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Live preview — the RepaintBoundary here is what we capture.
                // FittedBox + inner SizedBox let us render at the full capture
                // resolution while displaying within a fixed 260×260 box.
                SizedBox(
                  width: 260,
                  height: 260,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: captureSize.width,
                      height: captureSize.height,
                      child: RepaintBoundary(
                        key: captureKey,
                        child: ScreenshotRender(
                          locale: captureLocale,
                          platform: capturePlatform,
                          theme: captureTheme,
                          size: captureSize,
                          pixelDensity: capturePixelDensity,
                          builder: captureBuilder,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const LinearProgressIndicator(),
                const SizedBox(height: 8),
                ValueListenableBuilder<String>(
                  valueListenable: progressNotifier,
                  builder: (context, msg, child) => Text(msg),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Wait for the dialog (and its ScreenshotRender) to be built and painted.
    await WidgetsBinding.instance.endOfFrame;

    final outputBase = _outputBase;

    try {
      for (final locale in widget.locales) {
        for (final set in widget.screenshotSets) {
          for (var i = 0; i < set.storeScreenshots.length; i++) {
            final screenshot = set.storeScreenshots[i];

            final resolvedLocale = screenshot.locale ?? set.locale ?? locale;
            final resolvedPlatform =
                screenshot.targetPlatform ?? set.targetPlatform;
            final resolvedSize = screenshot.size ?? set.size;
            assert(
              resolvedSize != null,
              'A size must be provided on the StoreScreenshot or its parent ScreenshotSet.',
            );
            final resolvedPixelDensity =
                screenshot.pixelDensity ?? set.pixelDensity ?? 1.0;
            final resolvedTheme =
                screenshot.theme ?? set.theme ?? widget.appTheme;

            // Update the dialog to render this screenshot.
            setDialogState(() {
              captureLocale = resolvedLocale;
              captureSize = resolvedSize!;
              capturePixelDensity = resolvedPixelDensity;
              capturePlatform = resolvedPlatform;
              captureTheme = resolvedTheme;
              captureBuilder = screenshot.builder;
            });

            // Wait for the new content to be fully rendered.
            await WidgetsBinding.instance.endOfFrame;

            // Apply optional capture delay (e.g. to let fade-in animations
            // from cached_network_image finish before capturing).
            final captureDelay = screenshot.captureDelay ?? set.captureDelay;
            if (captureDelay != null) await Future.delayed(captureDelay);

            // Capture from the on-screen RepaintBoundary.
            final boundary =
                captureKey.currentContext?.findRenderObject()
                    as RenderRepaintBoundary?;
            if (boundary == null || boundary.size.isEmpty) {
              throw Exception(
                'Could not capture screenshot: render boundary is empty.',
              );
            }

            final image = await boundary.toImage(
              pixelRatio: resolvedPixelDensity,
            );
            final byteData = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            final bytes = byteData!.buffer.asUint8List();

            final setFolder = _sanitizeSetName(set.name);
            final localeTag = locale.toLanguageTag();
            final index = (i + 1).toString().padLeft(2, '0');
            final nameSuffix = screenshot.name != null
                ? '_${screenshot.name}'
                : '';
            final fileName = '$index$nameSuffix.png';
            final dir = Directory(
              '$outputBase${Platform.pathSeparator}$setFolder${Platform.pathSeparator}$localeTag',
            );
            await dir.create(recursive: true);
            await File(
              '${dir.path}${Platform.pathSeparator}$fileName',
            ).writeAsBytes(bytes);

            done++;
            progressNotifier.value = '$done / $total';
          }
        }
      }
    } finally {
      progressNotifier.dispose();
    }

    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved $done screenshots to $outputBase'),
          duration: const Duration(seconds: 6),
        ),
      );
    }
    await _checkScreenshotsDirExists();
  }

  static String _sanitizeSetName(String name) => name
      .replaceAll('"', 'in')
      .replaceAll(RegExp(r'[^\w]+'), '_')
      .replaceAll(RegExp(r'^_+'), '')
      .replaceAll(RegExp(r'_+$'), '');
}
