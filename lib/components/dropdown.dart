import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final DropDownBrain brain;
  DropDown({this.brain});
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int currentIndex = 0; //TODO : get getSettings

  getBack() {
    setState(() {
      currentIndex = (currentIndex-1) % this.widget.brain.getList().length;
    });
  }

  getNext() {
    setState(() {
      //currentIndex = (currentIndex++) % this.widget.list.length;
      currentIndex = (currentIndex+1) % this.widget.brain.getList().length;
    });
  }

  validate() {
    //TODO: send informations to the API
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
                heroTag: 'back',
                onPressed: () => getBack(),
                child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                )
            ),
          ),
          Text(
            this.widget.brain.getList()[currentIndex],
            style : TextStyle(
              fontSize : 20,
            ),
          ),
          SizedBox(
            width:100.0,
            height: 100.0,
            child: FloatingActionButton(
                heroTag: 'forward',
                onPressed: () => getNext(),
                child : Icon(
                    Icons.arrow_forward_ios,
                    size: 50.0,
                ),
            ),
          ),
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
              heroTag: 'validate',
              onPressed: () => validate(),
                child : Icon(
                    Icons.check,
                    size: 50.0,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
