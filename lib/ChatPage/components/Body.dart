import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  List? msgs = [];
  Body({Key? key, List? this.msgs}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final messages = [
    {
      "msg": "This is a sent message ",
      "time": "00:03",
      "sender": "Ryzerrector",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a recieved message",
      "time": "00:04",
      "sender": "Sender",
    },
    {
      "msg": "This is a sent message ",
      "time": "00:03",
      "sender": "Ryzerrector",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, i) {
          if (messages[i]["sender"] == "Ryzerrector") {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.pink,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(messages[i]["msg"].toString()),
                        Text("Sent on ${messages[i]["time"].toString()}"),
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
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.pink,
                    ),
                  ),
                  Container(
                    color: Colors.pink[200],
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(messages[i]["msg"].toString()),
                        Text("Sent on ${messages[i]["time"].toString()}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      /* ListView(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
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
      ), */
    );
  }
}
