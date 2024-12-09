import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
