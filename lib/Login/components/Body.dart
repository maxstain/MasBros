import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Center(
            heightFactor: 4.0,
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
            ),
            child: Text("Login"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
