import 'package:flutter/cupertino.dart';

abstract class Brain{
  getValue();
  String getReadableValue();
}

class RangeBrain extends Brain{
  Map parameters;
  Map param;
  double initValue;
  double upper;
  double lower;
  int divisions;
  String feature;
  RangeBrain({this.parameters, this.feature}){
    param = parameters[feature];
    lower = param['lower'];
    upper = param['upper'];
    divisions = param['divisions'];
    initValue = param['value'];
  }
  double getValue(){
    return initValue;
  }
  double getLower(){
    return this.lower;
  }
  double getUpper(){
    return this.upper;
  }
  int getDivisions(){
    return this.divisions;
  }
  String getReadableValue(){
    return initValue.toString();
  }
  String getFeature(){
    return this.feature;
  }
  setValue(double newValue){
    initValue = newValue;
  }

}

class SwitchBrain extends Brain{
  bool on;
  String feature;

  SwitchBrain({this.on, this.feature});

  bool getValue(){
    return this.on;
  }

  String getReadableValue(){
    if(on) return "On";
    else return "Off";
  }

  void setValue(bool on){
    this.on = on;
  }
}
class DropDownBrain extends Brain{

  List list;
  int index;
  String feature;
  DropDownBrain({@required this.list, this.feature});

  String getReadableValue(){
    return list[index];
  }
  List getList(){
    return list;
  }
  getValue(){
    return list[index];
  }

}
class NoBrain extends Brain{
  String error;
  NoBrain({this.error = '404'});
  String getValue(){
    return error;
  }
  String getReadableValue(){
    return getValue();
  }
}