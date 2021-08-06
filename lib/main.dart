import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Services/notification_service.dart';
import 'package:masbros/Splash/Splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MasterBros',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an Error! ${snapshot.error.toString()}");
            return Text("Oops, Something went wrong!");
          } else if (snapshot.hasData) {
            return SplashScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
