import 'package:flutter/material.dart';
import 'package:eye_oculus/constants.dart';

class Label extends StatelessWidget {

  final String content;
  Label({this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        child : Text(
          content,
          style : kTextStyleNumber,
        )
    );
  }
}
