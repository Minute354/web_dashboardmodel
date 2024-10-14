import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> attendanceList;
  final int presentCount;
  final int absentCount;

  ViewAttendanceScreen({
    required this.attendanceList,
    required this.presentCount,
    required this.absentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Summary'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Present Students: $presentCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Absent Students: $absentCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceList.length,
                itemBuilder: (context, index) {
                  var student = attendanceList[index];
                  return ListTile(
                    title: Text(student['name']),
                    trailing: Text(student['present'] ? 'Present' : 'Absent'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
