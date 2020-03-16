import 'package:flutterappgeolocator/models/employee.dart';
//import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';



abstract class EmployeeLeaveRequestState extends Equatable {
  const EmployeeLeaveRequestState();

  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeLeaveRequestState {}

class EmployeeLoaded extends EmployeeLeaveRequestState {

  final List<Employee> employees;

  const EmployeeLoaded([this.employees = const []]);

  @override
  List<Object> get props => [employees];

  @override
  String toString() {
    return 'EmployeeLoaded{employees: $employees}';
  }


}


class EmployeeNotLoaded extends EmployeeLeaveRequestState {}

