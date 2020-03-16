import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterappgeolocator/models/employee.dart';
import 'package:flutterappgeolocator/models/leave_request.dart';
import 'package:logger/logger.dart';
import './bloc.dart';


var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 10,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
);



class EmployeeLeaveRequestBloc extends Bloc<EmployeeLeaveRequestEvent, EmployeeLeaveRequestState> {
  @override
  EmployeeLeaveRequestState get initialState => EmployeeLoading();

  @override
  Stream<EmployeeLeaveRequestState> mapEventToState(
    EmployeeLeaveRequestEvent event,
  ) async* {
    if(event is LoadEmployee) {
      yield* _mapLoadEmployeeToState();
    } else if (event is UpdateEmployee) {
      yield*  _mapUpdateEmployeeToState(event);
    }
  }

  Future<List<Employee>> fetchEmployee() {
    // Imagine that this function is more complex and slow
    LeaveRequest leaveRequest1 = new LeaveRequest(
      id: 'L001',
      startDate: '0101',
      endDate: '0202',
      isChecked: false
    );

    LeaveRequest leaveRequest2 = new LeaveRequest(
        id: 'L002',
        startDate: '0101',
        endDate: '0202',
        isChecked: false
    );

    LeaveRequest leaveRequest3 = new LeaveRequest(
        id: 'L003',
        startDate: '0101',
        endDate: '0202',
        isChecked: false
    );

    List<LeaveRequest> leaveRequestList = [leaveRequest1, leaveRequest2, leaveRequest3];

    Employee employee1 = Employee(
        id: '001',
        name: 'Employee 1',
        isCheck: false,
        leaveRequestList: leaveRequestList
    );

    Employee employee2 = Employee(
        id: '002',
        name: 'Employee 2',
        isCheck: false,
        leaveRequestList: leaveRequestList
    );

    Employee employee3 = Employee(
        id: '003',
        name: 'Employee 3',
        isCheck: false,
        leaveRequestList: leaveRequestList
    );

    List<Employee> employees = new List();
    employees.add(employee1);
    employees.add(employee2);
    employees.add(employee3);


    return Future.delayed(Duration(seconds: 1), () => employees);
  }

  Stream<EmployeeLeaveRequestState> _mapLoadEmployeeToState() async* {
    try {
      logger.i("Testing load");
      final List<Employee>employees = await fetchEmployee();
      print(employees);
//      employees.add(employee1);
//      employees.add(employee2);
//      employees.add(employee3);
      logger.i("Added");

      print(employees);
//      logger.i("employees $employees");

      yield EmployeeLoaded(employees);
    } catch (_) {
      yield EmployeeNotLoaded();
    }
  }

  Stream<EmployeeLeaveRequestState> _mapUpdateEmployeeToState(UpdateEmployee event) async* {
    if(state is EmployeeLoaded) {
      final bool isAllChecked = event.employee.leaveRequestList.every((request) => request.isChecked);

      final List<LeaveRequest> updateLeaveRequest = event.employee.leaveRequestList
        .map((leaveRequest) => leaveRequest.copyWith(isChecked: !isAllChecked))
        .toList();

      event.employee.leaveRequestList = updateLeaveRequest;

      final List<Employee> updateEmployees = (state as EmployeeLoaded).employees.map((employee) {
        return employee.id == event.employee.id ? event.employee : employee;
      }).toList();

      yield EmployeeLoaded(updateEmployees);
    }
  }
}
