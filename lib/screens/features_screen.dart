import 'package:eye_oculus/constants.dart';
import 'package:flutter/material.dart';
import 'package:eye_oculus/components/feature_card.dart';

class Features extends StatelessWidget {
  static String id = 'features';
  final String appliance;

  Features({@required this.appliance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eye Oculus'),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: GridView.count(
          padding: EdgeInsets.all(20),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            FeatureCard(
              title: 'Turn on/off',
              appliance : kTurn,
            ),
            FeatureCard(
              title: 'Temperature',
              appliance : kTemperature,
            ),
            FeatureCard(
              title: 'Heating modes',
              appliance : kHeating,
            ),
            FeatureCard(
              title: 'Timer',
              appliance : kTimer,
            ),
            FeatureCard(
              title: 'Extend the rails',
              //TODO : show an alert about it
            ),
          ],
          //child : GridView();
        ),
      ),
    );
  }
}
