import 'package:flutter/material.dart';

class FlutterStoreScreenshotsApp extends StatelessWidget {
  const FlutterStoreScreenshotsApp({super.key, required this.screenshots});

  final List<Widget> screenshots;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Flutter Store Screenshots'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Row(
              children: [
                DropdownMenu(
                  initialSelection: 'en-US',
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 'en-US', label: 'en-US'),
                    DropdownMenuEntry(value: 'nl-NL', label: 'nl-NL'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: screenshots.length,
          itemBuilder: (context, index) => SizedBox(
            height: 600,
            width: 600,
            child: Center(child: screenshots[index]),
          ),
        ),
      ),
    );
  }
}
