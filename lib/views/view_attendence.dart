// Attendance view screen to display present and absent students
import 'package:flutter/material.dart';
import 'package:school_web_app/views/sidebars.dart';

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
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Present: $presentCount',
                      style: TextStyle(fontSize: 20)),
                  Text('Total Absent: $absentCount',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: attendanceList.length,
                      itemBuilder: (context, index) {
                        var student = attendanceList[index];
                        return ListTile(
                          title: Text(student['name']),
                          subtitle: Text(student['id']),
                          trailing:
                              Text(student['present'] ? 'Present' : 'Absent'),
                        );
                      },
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
