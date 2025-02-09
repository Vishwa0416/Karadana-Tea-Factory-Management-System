import 'package:flutter/material.dart';
import 'package:karadana_tea_factory/screens/home/homepage.dart';
import 'package:karadana_tea_factory/screens/start/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karadana Tea Factory',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
