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
        Exam(date: '2024-05-01', subject: 'Mathematics', time: '09:00 - 11:00', venue: 'Room 101'),
        Exam(date: '2024-05-02', subject: 'Physics', time: '10:00 - 12:00', venue: 'Room 102'),
      ],
      'B': [],
    },
    // ... (other classes and divisions)
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Exam Timetable',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  // Filters Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Class Dropdown
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Select Class', border: OutlineInputBorder()),
                          value: selectedClass,
                          items: [
                            DropdownMenuItem(child: Text('Class 10'), value: '10'),
                            DropdownMenuItem(child: Text('Class 11'), value: '11'),
                            DropdownMenuItem(child: Text('Class 12'), value: '12'),
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
                      // Division Dropdown
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Select Division', border: OutlineInputBorder()),
                          value: selectedDivision,
                          items: selectedClass == null
                              ? []
                              : examData[selectedClass!]!.keys
                                  .map((division) => DropdownMenuItem(
                                        child: Text('Division $division'),
                                        value: division,
                                      ))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDivision = value;
                              if (selectedClass != null && selectedDivision != null) {
                                displayedExams = examData[selectedClass!]![selectedDivision!]!;
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
                        ? Column(
                            children: [
                              // Data Table
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Venue', style: TextStyle(fontWeight: FontWeight.bold))),
                                    DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                                  ],
                                  rows: displayedExams.map((exam) {
                                    return DataRow(cells: [
                                      DataCell(Text(exam.date)),
                                      DataCell(Text(exam.subject)),
                                      DataCell(Text(exam.time)),
                                      DataCell(Text(exam.venue)),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () => _editExam(exam),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                              // Add Exam Button
                              SizedBox(height: 10), // Optional spacing
                              ElevatedButton(
                                onPressed: _addExam,
                                child: Text('Add Exam'),
                              ),
                            ],
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

  void _addExam() {
    showDialog(
      context: context,
      builder: (context) {
        String? date, subject, time, venue;
        return AlertDialog(
          title: Text('Add Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                onChanged: (value) => date = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Subject'),
                onChanged: (value) => subject = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) => time = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Venue'),
                onChanged: (value) => venue = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedClass != null && selectedDivision != null && date != null && subject != null && time != null && venue != null) {
                  setState(() {
                    examData[selectedClass!]![selectedDivision!]!.add(Exam(date: date!, subject: subject!, time: time!, venue: venue!));
                    displayedExams = examData[selectedClass!]![selectedDivision!]!;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editExam(Exam exam) {
    showDialog(
      context: context,
      builder: (context) {
        String? date = exam.date, subject = exam.subject, time = exam.time, venue = exam.venue;
        return AlertDialog(
          title: Text('Edit Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                onChanged: (value) => date = value,
                controller: TextEditingController(text: exam.date),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Subject'),
                onChanged: (value) => subject = value,
                controller: TextEditingController(text: exam.subject),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) => time = value,
                controller: TextEditingController(text: exam.time),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Venue'),
                onChanged: (value) => venue = value,
                controller: TextEditingController(text: exam.venue),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedClass != null && selectedDivision != null && date != null && subject != null && time != null && venue != null) {
                  setState(() {
                    final index = examData[selectedClass!]![selectedDivision!]!.indexOf(exam);
                    if (index != -1) {
                      examData[selectedClass!]![selectedDivision!]![index] = Exam(date: date!, subject: subject!, time: time!, venue: venue!);
                      displayedExams = examData[selectedClass!]![selectedDivision!]!;
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

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
