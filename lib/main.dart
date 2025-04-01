import 'package:appli_ena/auth/auth_gate.dart';
import 'package:appli_ena/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ENA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1C3D8F)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthGate(), // AuthGate is the entry point for authentication
      // and role management
      // home: const Redirection(), // Uncomment this line to use the Redirection widget
    );
  }
}

