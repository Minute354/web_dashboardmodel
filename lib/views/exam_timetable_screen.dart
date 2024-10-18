import 'package:flutter/material.dart';
import 'package:school_web_app/views/sidebars.dart';

class ExamTimetableScreen extends StatefulWidget {
  @override
  _ExamTimetableScreenState createState() => _ExamTimetableScreenState();
}

class _ExamTimetableScreenState extends State<ExamTimetableScreen> {
  String? selectedClass;
  String? selectedDivision;

  // Sample data structure: Class -> Division -> List of Exams
  final Map<String, Map<String, List<Exam>>> examData = {
    '10': {
      'A': [
        Exam(
            date: '2024-05-01',
            subject: 'Mathematics',
            time: '09:00 - 11:00',
            venue: 'Room 101'),
        Exam(
            date: '2024-05-02',
            subject: 'Physics',
            time: '10:00 - 12:00',
            venue: 'Room 102'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
      'B': [
        Exam(
            date: '2024-05-03',
            subject: 'Chemistry',
            time: '09:00 - 11:00',
            venue: 'Room 103'),
        Exam(
            date: '2024-05-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 104'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
    },
    '11': {
      'A': [
        Exam(
            date: '2024-06-01',
            subject: 'Advanced Mathematics',
            time: '09:00 - 11:00',
            venue: 'Room 201'),
        Exam(
            date: '2024-06-02',
            subject: 'Physics',
            time: '10:00 - 12:00',
            venue: 'Room 202'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
      'B': [
        Exam(
            date: '2024-06-03',
            subject: 'Chemistry',
            time: '09:00 - 11:00',
            venue: 'Room 203'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
    },
    '12': {
      'A': [
        Exam(
            date: '2024-07-01',
            subject: 'Mathematics',
            time: '09:00 - 11:00',
            venue: 'Room 301'),
        Exam(
            date: '2024-07-02',
            subject: 'Physics',
            time: '10:00 - 12:00',
            venue: 'Room 302'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
      'B': [
        Exam(
            date: '2024-07-03',
            subject: 'Chemistry',
            time: '09:00 - 11:00',
            venue: 'Room 303'),
        Exam(
            date: '2024-07-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 304'),
        Exam(
            date: '2024-06-04',
            subject: 'Biology',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Chemistry',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'English',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
        Exam(
            date: '2024-06-04',
            subject: 'Hindi',
            time: '10:00 - 12:00',
            venue: 'Room 204'),
      ],
    },
  };

  List<Exam> displayedExams = [];

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Title Aligned to Center
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Exam Timetable',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Filters Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Class Dropdown with Reduced Width
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.1, // 20% of screen width
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select Class',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedClass,
                          items: [
                            DropdownMenuItem(
                              child: Text('Class 10'),
                              value: '10',
                            ),
                            DropdownMenuItem(
                              child: Text('Class 11'),
                              value: '11',
                            ),
                            DropdownMenuItem(
                              child: Text('Class 12'),
                              value: '12',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedClass = value;
                              selectedDivision = null;
                              displayedExams = [];
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      // Division Dropdown with Reduced Width
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.1, // 20% of screen width
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select Division',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedDivision,
                          items: selectedClass == null
                              ? []
                              : examData[selectedClass!]!
                                  .keys
                                  .map(
                                    (division) => DropdownMenuItem(
                                      child: Text('Division $division'),
                                      value: division,
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDivision = value;
                              if (selectedClass != null &&
                                  selectedDivision != null) {
                                displayedExams = examData[selectedClass!]![
                                    selectedDivision!]!;
                              } else {
                                displayedExams = [];
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  // Timetable Display
                  Expanded(
                    child: displayedExams.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text(
                                    'Subject',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Venue',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              rows: displayedExams
                                  .map(
                                    (exam) => DataRow(cells: [
                                      DataCell(Text(exam.date)),
                                      DataCell(Text(exam.subject)),
                                      DataCell(Text(exam.time)),
                                      DataCell(Text(exam.venue)),
                                    ]),
                                  )
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Text(
                              selectedClass == null || selectedDivision == null
                                  ? 'Please select class and division to view timetable.'
                                  : 'No exams scheduled for the selected class and division.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle export or print functionality
        },
        child: Icon(Icons.print),
        tooltip: 'Print Timetable',
      ),
    );
  }
}

// Exam Model
class Exam {
  final String date;
  final String subject;
  final String time;
  final String venue;

  Exam({
    required this.date,
    required this.subject,
    required this.time,
    required this.venue,
  });
}
