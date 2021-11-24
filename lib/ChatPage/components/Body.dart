import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List? msgs = [];
  Body({Key? key, this.msgs}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: msgs!.length,
        itemBuilder: (BuildContext context, i) {
          if (msgs![i]["sender"] == user!.displayName.toString()) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("You"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.pink,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(msgs![i]["msg"].toString()),
                            Text("Sent on ${msgs![i]["time"].toString()}"),
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
                ],
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(msgs![i]["sender"]),
                  Row(
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(msgs![i]["msg"].toString()),
                            Text("Sent on ${msgs![i]["time"].toString()}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
