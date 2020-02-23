class Settings{

  static Map rangeParameters;
  static Map switchParameters;
  static Map dropDownParameters;

  static void setRangeParameters(String feature, double lowerBound, double upperBound, double value, int divisions){
    Map newParam = new Map();
    newParam['lowerBound'] = lowerBound;
    newParam['upperBound'] = upperBound;
    newParam['value'] = value;
    newParam['divisions'] = divisions;
    rangeParameters[feature] = newParam;
  }

  //TODO : add all getters

}