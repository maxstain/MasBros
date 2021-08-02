import 'package:flutter/material.dart';
import 'package:flutter_masterbros/HomePage/HomePage.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    controller.forward().then((_) async {
      await Future.delayed(Duration(seconds: 1));
      controller.reverse().then((value) => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
            ),
          });
    });
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedIcon(
        size: 200.0,
        color: Colors.pink,
        icon: AnimatedIcons.play_pause,
        progress: controller,
      ),
    );
  }
}
