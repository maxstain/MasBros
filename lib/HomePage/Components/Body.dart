import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masbros/HomePage/Components/AppointmentCard.dart';
import 'package:masbros/HomePage/HomePage.dart';
import 'package:masbros/Resources/Date.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 10,
      color: Colors.pink,
      backgroundColor: Colors.white,
      onRefresh: _refresh,
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Appointments").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: dates!.length <= 0
                  ? Text(
                      "No Appointments yet",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                leading: Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.pink,
                ),
                title: Text(
                  document["Date"],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  document["Time"],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    print("Pressed");
                    FirebaseFirestore.instance
                        .collection("Appointments")
                        .doc(document.id)
                        .delete();
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AppointmentCard(
                        id: document.id,
                        date: document["Date"],
                        time: document["Time"],
                        maker: document["Maker"],
                        photo: document["Photo"],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      ),
    );
  }
}
