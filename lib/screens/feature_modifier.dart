import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eye_oculus/constants.dart';
import 'package:eye_oculus/components/range.dart';
import 'package:eye_oculus/components/binary_choice.dart';
import 'package:eye_oculus/components/touch_back.dart';
import 'package:eye_oculus/components/dropdown.dart';
import 'package:eye_oculus/brain/brain_modifiers.dart';

class FeatureModifier extends StatefulWidget {

  final String feature;
  final String placeholder;
  FeatureModifier({@required this.feature, this.placeholder});

  @override
  _FeatureModifierState createState() => _FeatureModifierState();
}

class _FeatureModifierState extends State<FeatureModifier> {

  Widget modifier;
  Brain brain;
  Widget changerComponent(){
    Brain brainComponent;
    Widget widgetComponent;
    String feature = this.widget.feature;

    if(kRangeList.contains(feature)){
      brainComponent = new RangeBrain(parameters : kRangeParameters[feature]); //TODO : add personalized bounds
      widgetComponent = Range(brain: brainComponent);
    }
    else if(kBinList.contains(feature)){ //
      brainComponent = new SwitchBrain(on : true);

      widgetComponent = BinChoice(brain : brainComponent, parameter : kBinParameters[feature]);
    }
    else if(kDropdownList.contains(feature)){
      widgetComponent = DropDown(list : kDropDownListHeatingMode); //TODO add necessary parameters
    }
    else{
      brainComponent = new NoBrain(error : '404');
      widgetComponent = Container(child : Center(child: Text('No available components')));
    }

    brain = brainComponent;
    return widgetComponent;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modifier = changerComponent();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body : Padding(
        padding : EdgeInsets.all(15.0),
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children : [
            Expanded(
              child: TouchBack(
                childContent : Text(
                  this.widget.placeholder.toString(), // TODO : replace placeholder by "real values" --> use a class for the placeholder and change a class instance's value
                  style: kTextStyleNumber,
                ),
              ),
            ),
            Expanded(
              child : modifier,
            )
          ],
        ),
      ),
    );
  }
}
