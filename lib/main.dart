import 'package:appli_ena/auth/auth_gate.dart';
import 'package:appli_ena/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("🔔 [BG] Message: ${message.notification?.title}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialisation des notifications locales
  // const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  // const initSettings = InitializationSettings(android: androidInit);
  // await flutterLocalNotificationsPlugin.initialize(initSettings);

  // await flutterLocalNotificationsPlugin.initialize(
  //   const InitializationSettings(
  //     android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //     iOS: DarwinInitializationSettings(),
  //   ),
  // );


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

