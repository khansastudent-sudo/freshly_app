
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FreshlyApp());
}

class FreshlyApp extends StatelessWidget {
  const FreshlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFDF0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF86B87C),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEAF4CE),
          foregroundColor: Color(0xFF345B35),
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
