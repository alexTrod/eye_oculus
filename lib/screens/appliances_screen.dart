import 'package:eye_oculus/components/appliance_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppliancesList extends StatelessWidget {
  static String id = 'appliances_screen';
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
            ApplianceCard(title: 'Oven', appliance: 'oven'),
            ApplianceCard(title: 'Fridge', appliance: 'fridge'),
            ApplianceCard(title: 'Toaster', appliance: 'toaster'),
            ApplianceCard(title: 'Speech', appliance: 'speech'),
          ],
          //child : GridView();
        ),
      ),
    );
  }
}
