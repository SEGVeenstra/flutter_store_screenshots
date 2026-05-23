import 'package:flutter/material.dart';

class StoreScreenshot extends StatelessWidget {
  const StoreScreenshot({
    super.key,
    required this.locale,
    required this.builder,
    required this.size,
    required this.platform,
  });

  final Locale locale;
  final Size size;
  final TargetPlatform platform;

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(platform: platform),
      child: Localizations.override(
        context: context,
        locale: locale,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: builder(context),
            ),
          ),
        ),
      ),
    );
  }
}
