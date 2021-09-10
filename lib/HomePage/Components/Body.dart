import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Resources/Date.dart';
import 'package:masbros/Services/Appointments_Services.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Date>? dates = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("appointments");
    dbRef.child("appointments").once().then(
      (DataSnapshot dataSnapshot) {
        dates!.clear();
        var keys = dataSnapshot.value.keys;
        var values = dataSnapshot.value;
        for (var key in keys) {
          Date date = new Date(
            values[key]["Date"],
            values[key]["Time"],
          );
          dates!.add(date);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return dates!.length <= 0
        ? Center(
            child: Text(
              "No Appointments yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : ListView.builder(
            itemCount: dates!.length,
            itemBuilder: (_, i) {
              return ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  dates![i].date.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(dates![i].time.toString()),
              );
            },
          );
  }
}
