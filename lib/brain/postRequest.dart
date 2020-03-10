import 'dart:convert';
import 'request.dart';
import 'package:http/http.dart' as http;

const range = '{"temperature": {"value": 200,"lower_bound": 150,"upper_bound": 250}, "timer": {"value": 0,"lower_bound": 0,"upper_bound": 90}}';
const Switch = '{"turn": {"on": true},"light": {"on": false}}';
const dropDown = '{"heating": {"list": ["option 1","option 2","option 3"]}}';

const url = 'http://192.168.43.69:8888';

mixin PostRequest on Command{
}

class PostRangeRequest extends RangeRequest with PostRequest{

  //TODO : parse json and define settings
  //TODO : all modifiers should have the settings as parameters

  String valueToSend(String feature, double value){
    Map toSend =  {
      'featureType' : 'range',
      feature : {
        'value' : value
      }
    };
    return jsonEncode(toSend);
  }

  void postRequest(String feature, double value) async {

    print('sending a post request');
    var response;
    try {
      response = await http.post(url, body: valueToSend(feature, value));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    catch(e){
      print('error : $e');
    }

  }
  //var parsedJson = json.decode(range);
  //Settings.setRangeParameters(parsedJson['feature', ..]);
}

class PostDropdownRequest extends DropDownRequest with PostRequest{
  String valueToSend(String feature, String value){
    Map toSend =  {
      'featureType' : 'dropdown', // range | switch | dropdown
      feature : { //
        'value' : value, //
      }
    };
    return jsonEncode(toSend);
  }

  void postRequest(String feature, String value) async {

    print('sending a post request');
    var response;
    try {
      response = await http.post(url, body: valueToSend(feature, value));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    catch(e){
      print('error : $e');
    }

  }

}

class PostSwitchRequest extends SwitchRequest with PostRequest{}
