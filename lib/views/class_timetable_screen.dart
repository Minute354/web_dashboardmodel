import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/views/sidebars.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimeTableScreen> {
  String selectedClass = 'Class 1';
  String selectedDivision = 'A';

  // Timetable data for each class-division pair
  Map<String, List<List<String>>> timetableDataMap = {
    'Class 1-A': [
      ['Math', 'English', 'Science', 'History', 'PE'],
      ['English', 'Math', 'Science', 'History', 'PE'],
      ['Science', 'History', 'Math', 'English', 'PE'],
      ['History', 'English', 'PE', 'Math', 'Science'],
      ['PE', 'Math', 'Science', 'History', 'English'],
    ],
  };

  // Default timetable data
  List<List<String>> timetableData = [
    ['Math', 'English', 'Science', 'History', 'PE'], // Monday
    ['English', 'Math', 'Science', 'History', 'PE'], // Tuesday
    ['Science', 'History', 'Math', 'English', 'PE'], // Wednesday
    ['History', 'English', 'PE', 'Math', 'Science'], // Thursday
    ['PE', 'Math', 'Science', 'History', 'English'], // Friday
  ];

  // Time slots as columns
  final List<String> timeSlots = [
    '9:00-10:00',
    '10:00-11:00',
    '11:00-12:00',
    '12:00-1:00',
    '1:00-2:00'
  ];

  // Days as rows
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  final List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  final List<String> divisions = ['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
    _loadTimetableData();
  }

  // Load timetable for the selected class-division
  void _loadTimetableData() {
    String key = '$selectedClass-$selectedDivision';
    if (timetableDataMap.containsKey(key)) {
      timetableData = timetableDataMap[key]!;
    } else {
      timetableData = List.generate(
        5,
        (_) => List.generate(timeSlots.length, (_) => '---'), // Empty timetable
      );
    }
  }

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
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeaderWithAddButton(),
                    _buildTimetableTable(),
                  ],
                ),
                _buildEditButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header with "Timetable" text, class/division selector, and "Add" button
  Widget _buildHeaderWithAddButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Timetable',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton.icon(
              onPressed: () {
                _addNewTimetable();
              },
              icon: Icon(
                Icons.add,
                color: Colors.blueGrey.shade900,
              ),
              label: Text(
                'Add TimeTable',
                style: GoogleFonts.poppins(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: selectedClass,
                items: classes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedClass = newValue!;
                    _loadTimetableData();
                  });
                },
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: selectedDivision,
                items: divisions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDivision = newValue!;
                    _loadTimetableData();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Add new timetable for the selected class and division
  void _addNewTimetable() {
    String key = '$selectedClass-$selectedDivision';
    if (!timetableDataMap.containsKey(key)) {
      setState(() {
        timetableDataMap[key] = List.generate(
          5,
          (_) => List.generate(timeSlots.length, (_) => '---'),
        );
      });
    }
    _loadTimetableData();
  }

  Widget _buildTimetableTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FixedColumnWidth(150.0), // Day column width
            for (int i = 1; i <= timeSlots.length; i++)
              i: FixedColumnWidth(200.0), // Width for each time slot column
          },
          children: [
            _buildTableHeader(),
            for (int i = 0; i < days.length; i++) _buildTableRow(i),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      children: [
        _buildTableCell('Day'),
        for (String slot in timeSlots) _buildTableCell(slot),
      ],
    );
  }

  TableRow _buildTableRow(int dayIndex) {
    return TableRow(
      children: [
        _buildTableCell(days[dayIndex]),
        for (int i = 0; i < timeSlots.length; i++)
          _buildEditableTableCell(dayIndex, i),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEditableTableCell(int dayIndex, int slotIndex) {
    return InkWell(
      onTap: () {
        _openAddEditTimetableDialog(context, dayIndex, slotIndex);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          timetableData[dayIndex][slotIndex],
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: () {
          _openAddEditTimetableDialog(context);
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  void _openAddEditTimetableDialog(BuildContext context, [int? dayIndex, int? slotIndex]) {
    String subject = '';
    if (dayIndex != null && slotIndex != null) {
      subject = timetableData[dayIndex][slotIndex];
    }

    TextEditingController _subjectController = TextEditingController(text: subject);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dayIndex != null && slotIndex != null ? 'Edit Timetable' : 'Add Timetable'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (dayIndex != null && slotIndex != null) {
                  setState(() {
                    timetableData[dayIndex][slotIndex] = _subjectController.text;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
