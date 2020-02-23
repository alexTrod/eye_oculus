import 'request.dart';

mixin PostRequest on Command{
}
class GetRangeRequest extends RangeRequest with PostRequest{}
class GetSwitchRequest extends SwitchRequest with PostRequest{}
class GetDropDownRequest extends DropDownRequest with PostRequest{}
