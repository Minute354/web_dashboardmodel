import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_web_app/views/sidebars.dart';
import 'package:school_web_app/views/view_attendence.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedClass;
  String? _selectedDivision;

  final List<String> _classes = ['Class 1', 'Class 2', 'Class 3'];
  final List<String> _divisions = ['A', 'B', 'C'];

  // Mock attendance data mapped by class, division, and date
  final Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>>
      _attendanceData = {
    'Class 1': {
      'A': {
        '2024-10-10': [
          {'id': 'S101', 'name': 'John', 'present': true},
          {'id': 'S102', 'name': 'Jane', 'present': false},
        ],
      },
      'B': {
        '2024-10-10': [
          {'id': 'S103', 'name': 'Alice', 'present': true},
          {'id': 'S104', 'name': 'Bob', 'present': false},
        ],
      },
    },
    'Class 2': {
      'A': {
        '2024-10-10': [
          {'id': 'S105', 'name': 'Tom', 'present': true},
          {'id': 'S106', 'name': 'Jerry', 'present': false},
        ],
      },
      'B': {
        '2024-10-10': [
          {'id': 'S107', 'name': 'Smith', 'present': true},
          {'id': 'S108', 'name': 'Johnson', 'present': false},
        ],
      },
    },
  };

  List<Map<String, dynamic>> get _currentAttendance {
    if (_selectedClass == null || _selectedDivision == null) return [];

    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return _attendanceData[_selectedClass]?[_selectedDivision]
            ?[formattedDate] ??
        [];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _toggleAttendance(int index, bool? value) {
    setState(() {
      _currentAttendance[index]['present'] = value ?? false;
    });
  }

  void _viewAttendance() {
    int presentCount =
        _currentAttendance.where((student) => student['present']).length;
    int absentCount = _currentAttendance.length - presentCount;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewAttendanceScreen(
          attendanceList: _currentAttendance,
          presentCount: presentCount,
          absentCount: absentCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
         automaticallyImplyLeading:isSmallScreen?true: false,
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Date, Class, Division Selection Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date Picker
                      ElevatedButton.icon(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                        label: Text('Select Date'),
                      ),
                      // Class Dropdown
                      DropdownButton<String>(
                        value: _selectedClass,
                        hint: Text('Select Class'),
                        items: _classes.map((String className) {
                          return DropdownMenuItem<String>(
                            value: className,
                            child: Text(className),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedClass = newValue;
                            _selectedDivision =
                                null; // Reset division when class changes
                          });
                        },
                      ),
                      // Division Dropdown
                      DropdownButton<String>(
                        value: _selectedDivision,
                        hint: Text('Select Division'),
                        items: _selectedClass != null
                            ? _divisions.map((String divisionName) {
                                return DropdownMenuItem<String>(
                                  value: divisionName,
                                  child: Text(divisionName),
                                );
                              }).toList()
                            : [],
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDivision = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Display Selected Date, Class, and Division
                  Text('Date: $formattedDate'),
                  if (_selectedClass != null) Text('Class: $_selectedClass'),
                  if (_selectedDivision != null)
                    Text('Division: $_selectedDivision'),
                  SizedBox(height: 20),
                  // Attendance DataTable
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Present')),
                            DataColumn(label: Text('Absent')),
                          ],
                          rows:
                              List.generate(_currentAttendance.length, (index) {
                            var student = _currentAttendance[index];
                            return DataRow(cells: [
                              DataCell(Text(student['id'])),
                              DataCell(Text(student['name'])),
                              DataCell(
                                Checkbox(
                                  value: student['present'],
                                  onChanged: (bool? value) {
                                    _toggleAttendance(index, value);
                                  },
                                ),
                              ),
                              DataCell(
                                Checkbox(
                                  value: !student['present'],
                                  onChanged: (bool? value) {
                                    _toggleAttendance(index, !value!);
                                  },
                                ),
                              ),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _viewAttendance,
                    child: Text('View Attendance'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 50), // Full-width button
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
