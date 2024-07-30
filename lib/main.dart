import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/budgets_screen.dart';

void main() {
  runApp(const SmartTrackApp());
}

class SmartTrackApp extends StatelessWidget {
  const SmartTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
      '/': (context) => HomeScreen(),
      '/budgets': (context) => const BudgetsScreen(),
    },
    );
  }
}
