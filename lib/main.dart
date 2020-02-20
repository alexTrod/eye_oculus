import 'package:flutter/material.dart';
import 'package:eye_oculus/screens/appliances_screen.dart';
import 'package:eye_oculus/screens/features_screen.dart';
import 'package:eye_oculus/screens/feature_modifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => AppliancesList(),
        AppliancesList.id : (context) => AppliancesList(),
        Features.id : (context) => Features(),
      },
    );
  }
}
