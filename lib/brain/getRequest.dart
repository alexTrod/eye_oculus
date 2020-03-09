import 'request.dart';

const range = '{"temperature": {"value": 200,"lower_bound": 150,"upper_bound": 250}, "timer": {"value": 0,"lower_bound": 0,"upper_bound": 90}}';
const Switch = '{"turn": {"on": true},"light": {"on": false}}';
const dropDown = '{"heating": {"list": ["option 1","option 2","option 3"]}}';

mixin GetRequest on Command {

}
class GetRangeRequest extends RangeRequest with GetRequest{
  //This will be done for the final presentation
  //TODO : parse json and define settings
  //TODO : all modifiers should have the settings as parameters
  //var parsedJson = json.decode(range);
  //Settings.setRangeParameters(parsedJson['feature', ..]);
}
class GetSwitchRequest extends SwitchRequest with GetRequest{}
class GetDropDownRequest extends DropDownRequest with GetRequest{}
