import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Resources/db.dart';
import 'package:masbros/Services/Appointments_Services.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return dates.length > 0
        ? Container(
            child: new ListView.builder(
                itemCount: dates.length,
                itemBuilder: (BuildContext context, int i) {
                  String _title = dates[i]!.value;
                  String _subtitle = dates[i]!.value;
                  return new ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.pink,
                    ),
                    title: Text("Date: $_title"),
                    subtitle: Text("Time: $_subtitle"),
                    trailing: IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(
                          () {
                            dates.remove(dates[i]);
                          },
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Item Removed"),
                              content: Text("Item removed successfully"),
                              actions: [
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
          )
        : Container(
            child: Center(
              child: Text(
                "No appointments yet, get to it",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),
          );
  }
}
