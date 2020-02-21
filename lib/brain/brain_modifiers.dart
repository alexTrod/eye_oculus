abstract class Brain{
  getValue();
  String getReadableValue();
}

class RangeBrain extends Brain{
  Map parameters;
  int initValue;
  double upper;
  double lower;
  int divisions;
  RangeBrain({this.parameters}){
    lower = parameters['lower'];
    upper = parameters['upper'];
    divisions = parameters['divisions'];
    initValue = (lower+upper)~/2;
  }
  int getValue(){
    return initValue;
  }
  int getInitValue(){
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
  setValue(int newValue){
    initValue = newValue;
  }

}

class SwitchBrain extends Brain{
  bool on;

  SwitchBrain({this.on});

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