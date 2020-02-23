import 'package:flutter/material.dart';
import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class BinChoice extends StatefulWidget {

  final SwitchBrain brain;
  final Map parameter;
  BinChoice({@required this.brain, this.parameter});

  @override
  _BinChoiceState createState() => _BinChoiceState(brain : brain, parameter: parameter);
}

class _BinChoiceState extends State<BinChoice> {

  final SwitchBrain brain;
  final Map parameter;
  final assetsAudioPlayer = AssetsAudioPlayer();

  _BinChoiceState({this.brain, this.parameter});

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
                assetsAudioPlayer.open(
                  "assets/on.mp3",
                );
                assetsAudioPlayer.play();
              },
              child: Material(
                elevation: 5,
                color: Colors.white70,
                child: Center(
                  child: Icon(
                    parameter['iconOn'],
                    color: brain.getValue() ? parameter['colorOn'] : Colors.grey,
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
                assetsAudioPlayer.open(
                  "assets/off.mp3",
                );
                assetsAudioPlayer.play();
              },
              child: Material(
                elevation: 0,
                color: Colors.white70,
                child: Center(
                  child: Icon(
                    parameter['iconOff'],
                    color: brain.getValue() ? Colors.grey : parameter['colorOff'],
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

