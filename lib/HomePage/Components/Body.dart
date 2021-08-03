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
                  String _title = dates[i].year.toString() +
                      "-" +
                      dates[i].month.toString() +
                      "-" +
                      dates[i].day.toString();
                  String _subtitle = dates[i].hour.toString() +
                      "-" +
                      dates[i].minute.toString();
                  return new ListTile(
                    title: Text("Date: $_title"),
                    subtitle: Text("Time: $_subtitle"),
                  );
                }),
          )
        : Container(
            child: Center(
              child: Text("Empty"),
            ),
          );
  }
}
