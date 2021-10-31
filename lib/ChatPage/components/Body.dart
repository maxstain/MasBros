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
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Column(
                    children: [
                      Text("Text"),
                      Text("Sent on 23:11"),
                    ],
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.pink,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Column(
                    children: [
                      Text("Text"),
                      Text("Sent on 23:11"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
