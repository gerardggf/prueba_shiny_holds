import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Shiny holds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HoldWidget extends StatelessWidget {
  const HoldWidget({
    super.key,
    required this.left,
    required this.top,
  });

  final double left, top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Coordinates {
  final double x;
  final double y;

  Coordinates({
    required this.x,
    required this.y,
  });
}
