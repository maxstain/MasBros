import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masbros/HomePage/HomePage.dart';
import 'package:masbros/Services/Appointments_Services.dart';
import 'package:masbros/Services/Authentication_Service.dart';
import 'package:masbros/Services/notification_service.dart';
import 'package:masbros/Splash/Splash.dart';
import 'package:masbros/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>.value(
          value: AuthenticationService(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AppointmentsService>.value(
          value: AppointmentsService(),
        ),
        StreamProvider<User?>.value(
          value: AuthenticationService().user,
          initialData: null,
        ),
        StreamProvider.value(
          value: AppointmentsService().user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MasBros',
        themeMode: ThemeMode.system /*themeProvider.themeMode*/,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("You have an Error! ${snapshot.error.toString()}");
              return Text("Oops, Something went wrong!");
            } else if (snapshot.hasData) {
              return AuthenticationWrapper();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User?>(context);
    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      return HomePage();
    } else {
      return SplashScreen();
    }
  }
}
