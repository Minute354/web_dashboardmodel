import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_web_app/views/sidebars.dart';

void main() {
  runApp(MaterialApp(
    home: AttendanceScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _selectedDate = DateTime.now();

  // Mock attendance data mapped by date
  final Map<String, List<Map<String, dynamic>>> _attendanceData = {
    '2024-10-09': [
      {'id': 'S101', 'name': 'John ', 'present': true},
      {'id': 'S102', 'name': 'Jane ', 'present': false},
      {'id': 'S101', 'name': 'Smith ', 'present': true},
      {'id': 'S102', 'name': 'Johnson ', 'present': false},
      {'id': 'S103', 'name': 'Alice ', 'present': true},
      {'id': 'S101', 'name': 'Smith ', 'present': true},
      {'id': 'S102', 'name': 'sanju ', 'present': false},
      {'id': 'S103', 'name': 'aswadev ', 'present': true},
      {'id': 'S101', 'name': 'John Doe', 'present': true},
      {'id': 'S102', 'name': 'Jane Smith', 'present': false},
      {'id': 'S103', 'name': 'Alice Johnson', 'present': true},
      {'id': 'S101', 'name': 'John Doe', 'present': true},
      {'id': 'S102', 'name': 'Jane Smith', 'present': false},
      {'id': 'S103', 'name': 'Alice Johnson', 'present': true},
      // Add more students as needed
    ],
    // Add more dates and corresponding attendance data
  };

  // Get attendance for the selected date
  List<Map<String, dynamic>> get _currentAttendance {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return _attendanceData[formattedDate] ??
        List.generate(
          10,
          (index) => {
            'id': 'S10${index + 4}',
            'name': 'Student ${index + 4}',
            'present': false,
          },
        );
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

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(' '),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                
                children: [
                  
                  // Date Selection Row
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance ',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Attendance For The Date: $formattedDate',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                        label: Text('Select Date'),
                      ),
                    ],
                  ),
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
                          rows: List.generate(_currentAttendance.length, (index) {
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
                  // Save Button (Optional)
                  ElevatedButton(
                    onPressed: () {
                      // Handle save action, e.g., save attendance to database
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Attendance Saved for $formattedDate')),
                      );
                    },
                    child: Text('Save Attendance'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), // Full-width button
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
