import 'package:eye_oculus/constants.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  List list;
  DropDown({this.list});
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int currentIndex = 0; //TODO : get current value (through the API)

  getBack() {
    setState(() {
      currentIndex = (currentIndex) % this.widget.list.length;
    });
  }

  getNext() {
    setState(() {
      //currentIndex = (currentIndex++) % this.widget.list.length;
      currentIndex = (currentIndex+1) % this.widget.list.length;
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
          FloatingActionButton(
              heroTag: 'back',
              onPressed: () => getBack(),
              child: Icon(Icons.arrow_back_ios)
          ),
          Text(
            this.widget.list[currentIndex],
            style : TextStyle(
              fontSize : 40,
            ),
          ),
          FloatingActionButton(
              heroTag: 'forward',
              onPressed: () => getNext(),
              child : Icon(Icons.arrow_forward_ios),
          ),
          FloatingActionButton(
            heroTag: 'validate',
            onPressed: () => validate(),
              child : Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
