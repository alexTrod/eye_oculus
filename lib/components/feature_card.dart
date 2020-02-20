import 'package:eye_oculus/screens/feature_modifier.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {

  final String title;
  final String appliance;

  FeatureCard({@required this.title, @required this.appliance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // get the right component + set the necessary parameters
        Navigator.push(
          context,
          MaterialPageRoute(
              builder :(context) => FeatureModifier(feature: appliance)
          )
        );
      },
      child: Material(
        elevation: 0,
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(5.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
