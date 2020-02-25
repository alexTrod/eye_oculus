import 'dart:convert';
import 'request.dart';
import 'package:http/http.dart' as http;

const range = '{"temperature": {"value": 200,"lower_bound": 150,"upper_bound": 250}, "timer": {"value": 0,"lower_bound": 0,"upper_bound": 90}}';
const Switch = '{"turn": {"on": true},"light": {"on": false}}';
const dropDown = '{"heating": {"list": ["option 1","option 2","option 3"]}}';
const toSend = '{"temperature" : 100}';

mixin PostRequest on Command{
}

class PostRangeRequest extends RangeRequest with PostRequest{

  //TODO : parse json and define settings
  //TODO : all modifiers should have the settings as parameters

  void postRequest() async {
    print('sending a post request');
    var url = 'http://192.168.43.69:8888';
    var response = await http.post(url, body: toSend);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //print(await http.read('https://example.com/foobar.txt'));
  }
  //var parsedJson = json.decode(range);
  //Settings.setRangeParameters(parsedJson['feature', ..]);
}

class PostSwitchRequest extends SwitchRequest with PostRequest{}
class PostDropdownRequest extends DropDownRequest with PostRequest{}
