import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTurn = 'turn';
const kTimer = 'timer';
const kTemperature = 'temperature';
const kHeating = 'heating';
const kLight = 'light';

const kRangeList = [kTimer, kTemperature];
const kBinList = [kTurn, kLight];
const kDropdownList = [kHeating];

const kRangeParameters = {
  'temperature' : {
    'lower' : 150.0,
    'upper' : 250.0,
    'divisions' : 20,
  },
  'timer' : {
    'lower' : 0.0,
    'upper' : 90.0,
    'divisions': 90,
  }
};

const kBinParameters = {
  'turn' : {
    'iconOn' : Icons.check,
    'iconOff' : Icons.close,
    'colorOn' : Colors.greenAccent,
    'colorOff' : Colors.redAccent,
  },
  'light' : {
    'iconOn' : Icons.brightness_7 ,
    'iconOff' : Icons.highlight_off,
    'colorOn' : Colors.yellow,
    'colorOff' : Colors.blueGrey,
  }
};

const kTextStyleNumber = TextStyle(
  color : Colors.black54,
  fontSize : 80.0,
);

const kTextStyleText = TextStyle(

);

const kDropDownListHeatingMode = [
  'Conventional',
  'Bottom element',
  'Fan with grill',
  'Grill',
  'Defrosting'
];