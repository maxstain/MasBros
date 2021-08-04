import 'package:flutter/material.dart';
import 'package:flutter_masterbros/HomePage/Components/Body.dart';
import 'package:flutter_masterbros/Resources/Date.dart';
import 'package:flutter_masterbros/Resources/db.dart';
import 'package:flutter_masterbros/Services/notification_service.dart';
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
  late String _date;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
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
                  dates.add(new Date(_dateTime, _timeOfDay));
                  NotificationService().showNotification(
                    1,
                    "New appointment added",
                    "On: $_dateTime $_timeOfDay",
                    5,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
