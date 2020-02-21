import 'package:flutter/material.dart';
import 'package:eye_oculus/screens/features_screen.dart';
import 'package:eye_oculus/brain/speechRecognition.dart';
class ApplianceCard extends StatelessWidget {
  final String title;
  final String appliance;

  ApplianceCard({@required this.title, @required this.appliance});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //check which appliance
        if (appliance == 'oven') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Features(appliance: appliance), // pass parameter
              ));
        }
        else if(appliance == 'speech'){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SpeechCommand(), // pass parameter
              ));
        }
        else {
          //TODO : add a dialog 'this feature will be implemented soon'
        }
      },
      child: Material(
        elevation: 5,
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
