import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Account_Settings/Components/Update_Informations/Update_Informations.dart';
import 'package:masbros/Services/Authentication_Service.dart';
import 'package:masbros/main.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenticationService>(context);
    return Container(
      child: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Update informations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UpdateInformations(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(8.0),
            tileColor: Colors.red,
            leading: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            title: Text(
              "Delete account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21.0,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
              color: Colors.white,
            ),
            onTap: () async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:
                        Text("Are you sure you want to delete you account ?"),
                    content: Text(
                        "Deleting your account means that it will be lost forever"),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Delete"),
                        onPressed: () async {
                          await user!.delete();
                          await loginProvider.Logout();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
