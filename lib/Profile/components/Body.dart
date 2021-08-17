import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 90.0,
            ),
            child: Text("ProfileImage"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Ryzerrector",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text(
            "Groups",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black54,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => {},
        ),
      ],
    );
  }
}
