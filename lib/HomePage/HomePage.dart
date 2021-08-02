import 'package:flutter/material.dart';
import 'package:flutter_masterbros/HomePage/Components/body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MasBros.Inc"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("Pressed");
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}
