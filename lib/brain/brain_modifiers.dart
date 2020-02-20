abstract class Brain{
  getValue();
}

class RangeBrain extends Brain{
  Map parameters;
  int value;
  int upper;
  int lower;
  RangeBrain({this.parameters}){
    lower = parameters['lower'];
    upper = parameters['upper'];
    value = (lower+upper)~/2;
  }
  int getValue(){
    return value;
  }
  int getDownBound(){
    return lower;
  }

  int getUpperBound(){
    return upper;
  }
  void setValue(int newValue){
    value = newValue;
  }

}

class SwitchBrain extends Brain{
  bool on;

  SwitchBrain({this.on});

  bool getValue(){
    return this.on;
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
}