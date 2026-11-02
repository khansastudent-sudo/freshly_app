import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const FreshlyApp());

class FreshlyApp extends StatelessWidget {
  const FreshlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF91B97F)),
        scaffoldBackgroundColor: const Color(0xFFFFFCE9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF4B9),
          foregroundColor: Color(0xFF355D42),
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
