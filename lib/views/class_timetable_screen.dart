import 'package:flutter/material.dart';
import 'package:school_web_app/views/sidebars.dart';

// ignore: must_be_immutable
class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({super.key});

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  final List<String> timeSlots = [
    '9:00 - 9:50',
    '9:50 - 10:40',
    '11:00 - 11:50',
    '11:50 - 12:40',
    '2:00 - 2:40',
    "2:40 - 3:30"
  ];

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      ),
       drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
           if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Time Table', // This would be dynamic
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Dropdowns for Class and Division
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: DropdownButton<String>(
                          hint: Text('Select Class'),
                          items: ['Class 1', 'Class 2', 'Class 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Text('Select Division'),
                        items: ['A', 'B', 'C'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {},
                      ),
                    ],
                  ),
                  // Week Navigation
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                  // Timetable Table
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Table(
                        border: TableBorder.all(color: Colors.black, width: 1),
                        children: [
                          // First row: Time slots
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  height:
                                      60, // Set height for table header (optional)
                                  child: Center(
                                    child: Text(
                                      'Days/Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              for (var time in timeSlots)
                                TableCell(
                                  child: Container(
                                    height:
                                        60, // Set height for table header (optional)
                                    child: Center(
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          // Rows for each day
                          for (var day in days)
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    height:
                                        80, // Increase height for each cell (adjust as needed)
                                    child: Center(
                                      child: Text(
                                        day,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                for (int i = 0; i < timeSlots.length; i++)
                                  TableCell(
                                    child: Container(
                                      height:
                                          80, // Increase height for each cell (adjust as needed)
                                      child: Center(
                                        child: Text(
                                          'Subject', // Replace with actual subject/timetable data
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
