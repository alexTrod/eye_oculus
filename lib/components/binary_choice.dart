import 'package:flutter/material.dart';
import 'package:eye_oculus/brain/brain_modifiers.dart';

class BinChoice extends StatefulWidget {

  final SwitchBrain brain;
  BinChoice({this.brain});

  @override
  _BinChoiceState createState() => _BinChoiceState(brain : brain);
}

class _BinChoiceState extends State<BinChoice> {
  final SwitchBrain brain;
  _BinChoiceState({this.brain});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() =>  brain.setValue(true));
              },
              child: Material(
                elevation: 5,
                color: Colors.white70,
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: brain.getValue() ? Colors.green : Colors.grey,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() => brain.setValue(false));
              },
              child: Material(
                elevation: 5,
                color: Colors.white70,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: brain.getValue() ? Colors.grey : Colors.red,
                    size : 120,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

