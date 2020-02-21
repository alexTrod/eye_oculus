import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:flutter/material.dart';
import 'package:eye_oculus/constants.dart';
import 'package:eye_oculus/components/label.dart';

class Range extends StatefulWidget {
  final RangeBrain brain;
  final Map parameter;

  Range({this.brain, this.parameter});

  getBrain(){
    return this.brain;
  }

  @override
  _RangeState createState() => _RangeState(brain: brain, param : parameter);
}

class _RangeState extends State<Range> {

  double _value;
  final Map param;
  final RangeBrain brain;
  _RangeState({this.brain, @required this.param});

  void _setValue(double value) {
    setState(() {
      _value = value;
      this.widget.brain.setValue((_value*100).toInt());
    });
  }
  @override
  void initState() {
    super.initState();
    _value = brain.getInitValue().toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Column(
            children: <Widget>[
              Expanded(
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
                        divisions: brain.getDivisions(),
                        onChanged: _setValue,
                        //onChangeEnd: ,
                        //onChangeEnd : ,//TODO : after the user has chosen a value, value should be read out loud
                        min : brain.getLower(),
                        max: brain.getUpper(),
                      )),
                ),
              ),
              Label(
                content: _value.toInt().toString(),
              )
            ],
          ),
    );
  }
}
