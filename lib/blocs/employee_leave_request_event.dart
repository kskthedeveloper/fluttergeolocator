import 'package:flutterappgeolocator/models/employee.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeLeaveRequestEvent extends Equatable {
  const EmployeeLeaveRequestEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployee extends EmployeeLeaveRequestEvent {}

class UpdateEmployee extends EmployeeLeaveRequestEvent {
  final Employee employee;

  const UpdateEmployee(this.employee);

  @override
  List<Object> get props => [employee];

  @override
  String toString() {
    return 'UpdateEmployee{employee: $employee}';
  }

}

