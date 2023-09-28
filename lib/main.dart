import 'package:flutter/material.dart';
import 'package:test_tz/screen/home/view/home_screen.dart';
import 'package:test_tz/service/theme.dart';

Future<void> main() async {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ForestVPN test',
      theme: themeData,
      home: const HomeScreen(),
    );
  }
}
