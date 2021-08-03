import 'package:flutter/material.dart';
import 'package:flutter_masterbros/Resources/db.dart';

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
                  String _title = dates[i].date.year.toString() +
                      "-" +
                      dates[i].date.month.toString() +
                      "-" +
                      dates[i].date.day.toString();
                  String _subtitle = dates[i].time!.format(context).toString();
                  return new ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.pink,
                    ),
                    title: Text("Date: $_title"),
                    subtitle: Text("Time: $_subtitle"),
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
