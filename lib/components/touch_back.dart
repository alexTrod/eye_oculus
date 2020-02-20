import 'package:flutter/material.dart';
import 'package:eye_oculus/screens/features_screen.dart';

class TouchBack extends StatefulWidget {
  Text childContent;

  TouchBack({this.childContent});

  @override
  _TouchBackState createState() => _TouchBackState();
}

class _TouchBackState extends State<TouchBack> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        child: Center(child: this.widget.childContent),
      ),
    );
  }
}
