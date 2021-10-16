import 'package:flutter/material.dart';

class UpdateInformations extends StatefulWidget {
  UpdateInformations({Key? key}) : super(key: key);

  @override
  _UpdateInformationsState createState() => _UpdateInformationsState();
}

class _UpdateInformationsState extends State<UpdateInformations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Info"),
      ),
    );
  }
}
