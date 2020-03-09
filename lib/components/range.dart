import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:flutter/material.dart';
import 'package:eye_oculus/components/label.dart';
import 'package:eye_oculus/brain/settings.dart';
import 'package:eye_oculus/brain/postRequest.dart';

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
      this.widget.brain.setValue((_value*100));
    });
  }
  void _sendValue(double value){
    //TODO: read value out loud
    PostRangeRequest postRequest = PostRangeRequest();
    postRequest.postRequest(this.widget.brain.getFeature(), value);
    Settings.setRangeParameters(value, this.widget.brain.getFeature());
  }
  @override
  void initState() {
    super.initState();
    print(brain);
    _value = brain.getValue().toDouble();
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
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 30.0),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 50.0),
                          activeTrackColor: Colors.black38,
                          disabledActiveTrackColor: Colors.blueGrey),
                      child: Slider(
                        value: _value,
                        divisions: brain.getDivisions(),
                        onChanged: _setValue,
                        onChangeEnd: _sendValue,
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

