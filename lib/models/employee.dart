import 'package:equatable/equatable.dart';
import 'leave_request.dart';
import 'package:meta/meta.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final bool isCheck;
  final List<LeaveRequest> leaveRequestList;

  Employee({this.id, String name = '', this.leaveRequestList, this.isCheck}) : this.name = name?? '';

//  void set leaveRequestList(List<LeaveRequest> list) {
//    this.leaveRequestList = list;
//  }

  @override
  List<Object> get props => [id, name, leaveRequestList, isCheck];


  Employee copyWith({String id, String name, List<LeaveRequest> leaveRequestList, bool isCheck}) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      leaveRequestList: leaveRequestList ?? this.leaveRequestList,
      isCheck: isCheck ?? this.isCheck
    );
  }

  @override
  String toString() {
    return 'Employee{id: $id, name: $name, isCheck: $isCheck, leaveRequestList: $leaveRequestList}';
  }


}