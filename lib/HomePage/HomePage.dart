import 'package:flutter/material.dart';
import 'package:flutter_masterbros/HomePage/Components/Body.dart';
import 'package:flutter_masterbros/Resources/DateTable.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _dateTime = DateTime.now();
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
              setState(() {
                _dateTime = pickedDate.toLocal();
                dates.add(_dateTime.toString());
              });
              return print("$_dateTime");
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
