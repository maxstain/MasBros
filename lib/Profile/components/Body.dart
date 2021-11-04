import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Account_Settings/Account_Settings.dart';
import 'package:masbros/theme_provider.dart';
import 'package:masbros/widgets/change_theme_button.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Icon mode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? Icon(Icons.light_mode_outlined)
            : Icon(Icons.dark_mode);
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? "Light Mode"
        : "Dark Mode";
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 50.0,
            ),
            child: CircleAvatar(
              radius: 100.0,
              backgroundImage: user!.photoURL != null
                  ? NetworkImage(user!.photoURL.toString())
                  : NetworkImage("https://picsum.photos/250?image=9"),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "${user!.displayName}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.pink,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            "Account Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountSettings(),
              ),
            ),
          },
        ),
        ListTile(
          leading: mode,
          title: Text(
            text + " (WIP)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          trailing: ChangeThemeButton(),
        ),
      ],
    );
  }
}
