import 'package:flutter/material.dart';

import '../models/store_screenshot.dart';

/// Returns a list of [count] [StoreScreenshot]s that together form a seamless
/// panoramic layout across multiple store screenshots.
///
/// All screenshots share the same [panoramaBuilder]. That builder receives a
/// [BuildContext] where `MediaQuery.sizeOf(ctx).width` equals
/// `screenshotWidth × count`, so the panorama can lay itself out across the
/// full combined width using a [Row] or a [Stack].
///
/// Each generated screenshot clips its own horizontal slice of the panorama:
/// screenshot `i` shows the portion from `x = screenshotWidth × i` to
/// `x = screenshotWidth × (i + 1)`.
///
/// ## Usage
///
/// ```dart
/// AppleScreenshotSet.iPhone67(
///   storeScreenshots: panoramicCanvas(
///     count: 3,
///     names: ['home', 'detail', 'settings'],
///     panoramaBuilder: (context) {
///       final w = MediaQuery.sizeOf(context).width; // total panorama width
///       final sliceW = w / 3;                        // single screenshot width
///       return Container(
///         decoration: const BoxDecoration(
///           gradient: LinearGradient(
///             colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
///           ),
///         ),
///         child: Row(
///           children: [
///             SizedBox(width: sliceW, child: /* screenshot 0 content */),
///             SizedBox(width: sliceW, child: /* screenshot 1 content */),
///             SizedBox(width: sliceW, child: /* screenshot 2 content */),
///           ],
///         ),
///       );
///     },
///   ),
/// )
/// ```
///
/// - [count] — number of screenshots to generate.
/// - [panoramaBuilder] — builder for the full-width panorama widget.
/// - [names] — optional per-screenshot file name suffixes. When omitted,
///   screenshots are named `panoramic_0`, `panoramic_1`, etc.
List<StoreScreenshot> panoramicCanvas({
  required int count,
  required WidgetBuilder panoramaBuilder,
  List<String>? names,
}) {
  assert(
    names == null || names.length == count,
    'names.length must equal count when provided.',
  );
  return List.generate(count, (index) {
    return StoreScreenshot(
      name: names != null ? names[index] : 'panoramic_$index',
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        final totalWidth = size.width * count;

        // 1. ClipRect — clips the painted output to the screenshot canvas.
        // 2. OverflowBox — passes panorama-sized constraints to the child so
        //    the builder can lay out at the full combined width.
        // 3. Transform.translate — shifts the panorama left so that the slice
        //    for this index is aligned with the left edge of the canvas.
        return ClipRect(
          child: OverflowBox(
            alignment: Alignment.topLeft,
            minWidth: totalWidth,
            maxWidth: totalWidth,
            minHeight: size.height,
            maxHeight: size.height,
            child: Transform.translate(
              offset: Offset(-size.width * index, 0),
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: Size(totalWidth, size.height)),
                child: Builder(builder: panoramaBuilder),
              ),
            ),
          ),
        );
      },
    );
  });
}
