import 'package:flutter/material.dart';
import 'package:masbros/Login/LoginPage.dart';
import 'package:masbros/Services/Authentication_Service.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Center(
            heightFactor: 4.0,
            child: Text(
              "Sign In",
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20.0, left: 8.0, right: 8.0),
            child: TextFormField(
              controller: emailController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                /* context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ); */
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text("Already have an account ?"),
                TextButton(
                  child: Text("Log In"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
