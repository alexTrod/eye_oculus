import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eye_oculus/constants.dart';
import 'package:eye_oculus/components/range.dart';
import 'package:eye_oculus/components/binary_choice.dart';
import 'package:eye_oculus/components/touch_back.dart';
import 'package:eye_oculus/components/dropdown.dart';
import 'package:eye_oculus/brain/brain_modifiers.dart';
import 'package:eye_oculus/brain/settings.dart';

class FeatureModifier extends StatefulWidget {

  final String feature;
  final String placeholder;
  FeatureModifier({@required this.feature, this.placeholder});

  @override
  _FeatureModifierState createState() => _FeatureModifierState();
}

class _FeatureModifierState extends State<FeatureModifier> {

  final String placeholder;
  Widget modifier;
  Brain brain;

  _FeatureModifierState({this.placeholder});

  Widget changerComponent(){
    Widget widgetComponent;
    String feature = this.widget.feature;

    if(kRangeList.contains(feature)){
      //TODO step1
      print('feature = '+feature);
      brain = new RangeBrain(parameters : Settings.getRangeParameters(), feature : feature);
      widgetComponent = Range(brain: brain, parameter : Settings.getRangeParameters());
    }
    else if(kBinList.contains(feature)){ //
      brain = new SwitchBrain(on : true, feature:feature);

      widgetComponent = BinChoice(brain : brain, parameter : kBinParameters[feature]);
    }
    else if(kDropdownList.contains(feature)){
      brain = new DropDownBrain(list : Settings.getDropDownParameters(), feature: feature);
      widgetComponent = DropDown(brain: brain);
    }
    else{
      brain = new NoBrain(error : '404');
      widgetComponent = Container(child : Center(child: Text('No available components')));
    }

    return widgetComponent;

  }

  @override
  void initState() {
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
                  "",
                  //brain.getReadableValue(),
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
