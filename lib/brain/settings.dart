class Settings{

  static Map rangeParameters =
  {
    'temperature' : {
      'lower' : 150.0,
      'upper' : 250.0,
      'divisions' : 20,
      'value' : 200.0,
    },
    'timer' : {
      'lower' : 0.0,
      'upper' : 90.0,
      'divisions': 90,
      'value' : 45.0,
    }
  };
  static Map switchParameters;
  static Map dropDownParameters;

  static void setRangeParameters(double value, String feature){
    rangeParameters[feature]['value'] = value;
  }

  static getRangeParameters() { return rangeParameters;}

  static void setSwitchParameters(bool value, String feature){
    //
  }
  //TODO : add all getters & setters

}