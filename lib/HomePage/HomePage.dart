import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masbros/HomePage/Components/Body.dart';
import 'package:masbros/Resources/Date.dart';
import 'package:masbros/Resources/db.dart';
import 'package:masbros/Services/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _dateTime = DateTime.now();
  late TimeOfDay? _timeOfDay = TimeOfDay.now();
  late Date date;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference appointments =
        FirebaseFirestore.instance.collection('appointments');
    Future<void> addAppointment(Date date) {
      return appointments
          .add(date)
          .then((value) => print("Appointment added"))
          .catchError((error) => print("Failed to add appointment! $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("MasBros.Inc"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final DateTime pickedDate = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DatePickerDialog(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2021),
                    lastDate: DateTime.utc(3030),
                  );
                },
              );
              final TimeOfDay? pickedTime = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              setState(
                () {
                  _dateTime = pickedDate.toLocal();
                  _timeOfDay = pickedTime;
                  date = new Date(_dateTime, _timeOfDay);
                  dates.add(date);
                  NotificationService().showNotification(
                    1,
                    "New appointment added",
                    "On: " +
                        _dateTime.year.toString() +
                        "-" +
                        _dateTime.month.toString() +
                        "-" +
                        _dateTime.day.toString() +
                        " - " +
                        _timeOfDay!.format(context).toString(),
                    1,
                  );
                },
              );
              addAppointment(date);
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
