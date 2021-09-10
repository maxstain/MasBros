import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masbros/Resources/Date.dart';
import 'package:masbros/Services/Appointments_Services.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();

  @override
  void initState() {
    initState();
    AppointmentsService().getAppointment();
  }
}

class _BodyState extends State<Body> {
  List<Date>? appointments = AppointmentsService().getAppointment();
  @override
  Widget build(BuildContext context) {
    return appointments!.length <= 0
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
            itemCount: appointments!.length,
            itemBuilder: (_, i) {
              return ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  appointments![i].date.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(appointments![i].time.toString()),
              );
            },
          );
  }
}
