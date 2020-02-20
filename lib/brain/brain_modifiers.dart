abstract class Brain{
  getValue();
}

class RangeBrain extends Brain{
  int lower;
  int up;
  int value;

  RangeBrain({this.lower, this.up}){
    value = (lower+up)~/2;
  }
  int getValue(){
    return value;
  }
  int getDownBound(){
    return this.lower;
  }

  int getUpperBound(){
    return this.up;
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