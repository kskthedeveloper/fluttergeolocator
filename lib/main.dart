import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappgeolocator/blocs/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:trust_fall/trust_fall.dart';

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

void main() {
  runApp(
      BlocProvider(
        create: (context) {
          return EmployeeLeaveRequestBloc()..add(LoadEmployee());
        },
        child: MaterialApp(
            home: Scaffold(
              body: MyApp2(),
            )
        ),
      )
  );
}

class MyApp2 extends StatelessWidget {
  static final List<String> _listViewData = [
    "100016",
    "10012",
    "100013",
    "100010",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeLeaveRequestBloc, EmployeeLeaveRequestState>(
        builder: (context, state) {
          if (state is EmployeeLoaded) {
            logger.i("Testing");
            final employees = state.employees;

            List<ExpansionTile> _listOfExpansions = List<ExpansionTile>.generate(
                employees.length,
                    (i) =>
                    ExpansionTile(
                      leading: Checkbox(
                        value: employees[i].isCheck,
                        onChanged: (_) {
                          BlocProvider.of<EmployeeLeaveRequestBloc>(context).add(
                            UpdateEmployee(employees[i].copyWith(isCheck: !employees[i].isCheck))
                          );
                        },
                      ),
                      title: Text(
                          '${employees[i]} -   Requested : 10/02/2020',
                          style: TextStyle(fontSize: 15, color: Colors.blue)),
                      children: employees[i].leaveRequestList
                          .map((data) =>
                          Card(
                            child: ListTile(
                              leading: Checkbox(
                                value: data.isChecked,
                                onChanged: (_) {

                                },
                              ),
                              title: Text(
                                "$data",
                                style:
                                TextStyle(color: Colors.blueGrey, fontSize: 15),
                              ),
                              subtitle: Text("11 Mar 2020 - 11 Mar 2020"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FlatButton(
                                    textColor: Colors.blue,
                                    child: Text(
                                      "Test",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      logger.i("Test");
                                    },
                                  ),
                                  FlatButton(
                                    textColor: Colors.blue,
                                    child: Text(
                                      "Test",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      logger.i("Test");
                                    },
                                  )
                                ],
                              ),
                            ),
                          ))
                          .toList(),
                    ));

            return
            ListView(
              padding: EdgeInsets.all(8.0),
              children:
              _listOfExpansions.map((expansionTile) => expansionTile).toList(),
            );

          }
          return Container();
        }
    );
  }


}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentPosition;
  bool _fakeLocationOn;

  @override
  void initState() {
//    logger.d("This is initState");
//    TrustFall.canMockLocation
//        .then(_checkFakeGPS)
//        .then((data) => _getCurrentPosition());
//    TrustFall.canMockLocation.then((data) => _checkFakeGPS(data));
//  _getCurrentPosition();
  }

  _checkFakeGPS(bool data) {
    logger.d("Checking fake gps", data);
    _fakeLocationOn = data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        body: Center(
////          child: Column(
////            mainAxisAlignment: MainAxisAlignment.center,
////            children: <Widget>[
////              Text('Position $_currentPosition'),
////              MaterialButton(
////                child: Text('Get Location'),
////                onPressed: _getCurrentPosition,
////              )
////            ],
////          ),
//        ),
        body: ExpandableListView(context),
      ),
    );
  }

  _getCurrentPosition() async {
    logger.i("get current position");
    if (_currentPosition == null) {
      Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          logger.d("Position $position");
          logger.d("isFackLocOn $_fakeLocationOn");
          _currentPosition = position;
        });
      });
    } else {
      logger.d("Position $_currentPosition");
      logger.d("isFackLocOn $_fakeLocationOn");
    }
  }
}

class ExpandableListView extends StatelessWidget {
  ExpandableListView(this.context);

  final BuildContext context;
  List<String> employeeNames = ["James", "Tonny", "Robin", "Jenny"];
  static final List<String> _listViewData = [
    "100016",
    "10012",
    "100013",
    "100010",
  ];

  @override
  Widget build(BuildContext context) {
    List<ExpansionTile> _listOfExpansions = List<ExpansionTile>.generate(
        employeeNames.length,
            (i) =>
            ExpansionTile(
              title: Text(
                  employeeNames[i] + "              Requested : 10/02/2020",
                  style: TextStyle(fontSize: 15, color: Colors.blue)),
              children: _listViewData
                  .map((data) =>
                  Card(
                    child: ListTile(
                      title: Text(
                        employeeNames[i] + " - " + data,
                        style:
                        TextStyle(color: Colors.blueGrey, fontSize: 15),
                      ),
                      subtitle: Text("11 Mar 2020 - 11 Mar 2020"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FlatButton(
                            textColor: Colors.blue,
                            child: Text(
                              "Test",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              logger.i("Test");
                            },
                          ),
                          FlatButton(
                            textColor: Colors.blue,
                            child: Text(
                              "Test",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              logger.i("Test");
                            },
                          )
                        ],
                      ),
                    ),
                  ))
                  .toList(),
            ));
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children:
        _listOfExpansions.map((expansionTile) => expansionTile).toList(),
      ),
    );
  }
}
