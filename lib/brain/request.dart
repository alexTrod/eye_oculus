import 'package:eye_oculus/brain/settings.dart';
import 'package:http/http.dart' as http;

const url = 'https://localhost';

abstract class Command {
  String feature;
}
class RangeRequest extends Command{
  static const URL_RELATIVE = 'range';

  double lowerBound;
  double upperBound;
  double value;

  //set kRangeParameters
}

class SwitchRequest extends Command{
  static const URL_RELATIVE = 'switch';

  bool on;

  //set kSwitchParameters
}

class DropDownRequest extends Command {
  static const URL_RELATIVE = 'dropdown';

  String value;
  List listValues;

  //set kDropDownParameters
}