import 'package:flutter/material.dart';
import 'package:flutter_masterbros/Resources/DateTable.dart';

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
                  return new ListTile(
                    title: Text(dates[i]),
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
