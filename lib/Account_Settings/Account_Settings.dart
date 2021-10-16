import 'package:flutter/material.dart';
import 'package:masbros/Account_Settings/Components/Body.dart';

class AccountSettings extends StatefulWidget {
  AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: Body(),
    );
  }
}
