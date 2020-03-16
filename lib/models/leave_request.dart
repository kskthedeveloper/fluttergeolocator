import 'package:equatable/equatable.dart';

class LeaveRequest extends Equatable {
  final String id;
  final String startDate;
  final String endDate;
  final bool isChecked;

  LeaveRequest({this.id, this.startDate, this.endDate, this.isChecked});

  @override
  List<Object> get props => [id, startDate, endDate, isChecked];


}
