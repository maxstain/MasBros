import 'package:flutter/material.dart';
import 'package:flutter_masterbros/Services/notification_service.dart';
import 'package:flutter_masterbros/Splash/Splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MasterBros',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SplashScreen(),
    );
  }
}
