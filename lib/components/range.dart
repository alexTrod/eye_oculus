import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:flutter/material.dart';

class Range extends StatefulWidget {
  final RangeBrain brain;
  Range({this.brain});

  getBrain(){
    return this.brain;
  }

  @override
  _RangeState createState() => _RangeState();
}

class _RangeState extends State<Range> {
  double _value = 0.0;
  void _setValue(double value) {
    setState(() {
      _value = value;
      this.widget.brain.setValue(value.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: 1,
        child: SliderTheme(
            data: SliderThemeData(
                overlayColor: Colors.blueGrey,
                trackHeight: 20.0,
                thumbColor: Colors.black45,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                activeTrackColor: Colors.black38,
                disabledActiveTrackColor: Colors.blueGrey),
            child: Slider(
              value: _value,
              divisions: 100,
              onChanged: _setValue,
              //onChangeEnd: ,
              //onChangeEnd : ,//TODO : after the user has chosen a value, value should be read out loud
            )),
      ),
    );
  }
}
