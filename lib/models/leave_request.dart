import 'package:equatable/equatable.dart';

class LeaveRequest extends Equatable {
  final String id;
  final String startDate;
  final String endDate;
  final bool isChecked;

  LeaveRequest({this.id, this.startDate, this.endDate, this.isChecked});

  LeaveRequest copyWith({String id, String startDate, String endDate, bool isChecked}) {
    return LeaveRequest(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isChecked: isChecked ?? this.isChecked
    );
  }

  @override
  List<Object> get props => [id, startDate, endDate, isChecked];

  @override
  String toString() {
    return 'LeaveRequest{id: $id, startDate: $startDate, endDate: $endDate, isChecked: $isChecked}';
  }


}
