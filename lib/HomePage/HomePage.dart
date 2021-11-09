import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masbros/ChatPage/ChatPage.dart';
import 'package:masbros/HomePage/Components/Body.dart';
import 'package:masbros/Login/LoginPage.dart';
import 'package:masbros/Profile/Profile.dart';
import 'package:masbros/Resources/Date.dart';
import 'package:masbros/Resources/db.dart';
import 'package:masbros/Services/Appointments_Services.dart';
import 'package:masbros/Services/Authentication_Service.dart';
import 'package:masbros/Services/notification_service.dart';
import 'package:masbros/main.dart';
import 'package:provider/provider.dart';
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
    final loginProvider = Provider.of<AuthenticationService>(context);
    final appointmentsProvider = Provider.of<AppointmentsService>(context);
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatPage(),
              ),
            );
          });
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user!.displayName.toString()),
              accountEmail: Text(user.email.toString()),
              currentAccountPicture: Image.network(user.photoURL.toString()),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                size: 30.0,
                color: Colors.pink,
              ),
              title: Text(
                "Profile",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 25.0,
              ),
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.pink,
                size: 30.0,
              ),
              title: Text(
                "Log Out",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 25.0,
              ),
              onTap: () async => await loginProvider.Logout(),
            ),
          ],
        ),
      ),
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
              appointmentsProvider.addAppointment(
                _dateTime.year.toString() +
                    "-" +
                    _dateTime.month.toString() +
                    "-" +
                    _dateTime.day.toString(),
                _timeOfDay!.format(context).toString(),
                user.displayName.toString(),
                user.photoURL.toString(),
              );
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AuthenticationWrapper()));
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
