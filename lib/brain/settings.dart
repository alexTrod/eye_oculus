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
  static Map switchParameters =
  {
    'turn':{
      'on' : false,
    },
    'light':{
      'on' : false,
    }
  };
  static Map dropDownParameters =
    {
      'heating': { // range | switch | dropdown
        'value' : 'Conventional',
        'list' : ['Conventional',
          'Bottom element',
          'Fan with grill',
          'Grill',
          'Defrosting'],
      }
  };

  static getRangeParameters() {return rangeParameters;}
  static getDropDownParameters(){return dropDownParameters;}
  static getSwitchParameters(){ return switchParameters;}

  static void setRangeParameters(double value, String feature){
    rangeParameters[feature]['value'] = value;
  }

  static void setDropDownParameters(bool value, String feature){
    dropDownParameters[feature]['value'] = value;
  }

  static void setSwitchParameters(bool value, String feature){
    switchParameters[feature]['on'] = value;
  }

}