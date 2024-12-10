import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/property_bloc.dart';
import 'repositories/property_repository.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PropertyBloc(PropertyRepository()),
          ),
        ],
        child: MaterialApp(
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
        ));
  }
}
