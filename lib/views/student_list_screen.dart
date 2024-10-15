import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/student_controller.dart';
import 'package:school_web_app/models/student_model.dart';
import 'package:school_web_app/views/sidebars.dart';
import 'add_student_screen.dart';
import 'edit_student.dart';

class StudentListPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  StudentListPage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Students',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddStudentPage()),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text(
                            'Add Student',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade900,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Search TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search by name',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.indigo, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (value) {
                                // Filter students based on the input
                                context
                                    .read<StudentController>()
                                    .filterStudents(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<StudentController>(
                      builder: (context, studentController, child) {
                        return Column(
                          children: [
                            // DataTable Header
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 400,
                              child: DataTable(
                                columnSpacing: 20.0,
                                headingRowColor: WidgetStateProperty.all(
                                    Colors.blueGrey.shade900),
                                border: TableBorder.all(
                                  color: Colors.grey,
                                  width: 1,
                                ), // Thicker border for DataTable
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'No',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Class',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Division',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Actions',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  studentController.students.length,
                                  (index) {
                                    final student =
                                        studentController.students[index];
                                    return DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(student.name)),
                                        DataCell(Text(student.studentClass)),
                                        DataCell(Text(student.division)),
                                        DataCell(
                                          Chip(
                                            label: SizedBox(
                                              width: 50,
                                              child: Text(
                                                student.isActive
                                                    ? 'Active'
                                                    : 'Inactive',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            backgroundColor: student.isActive
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        DataCell(
                                          _buildActionButtons(context, student,
                                              studentController),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Show message if no records found
                            if (studentController.students.isEmpty)
                              Center(
                                child: Text(
                                  'No records found',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
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

  Widget _buildActionButtons(
      BuildContext context, Student student, StudentController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blueAccent),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditStudentPage(student: student),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(
            student.isActive ? Icons.cancel : Icons.check_circle,
            color: student.isActive ? Colors.redAccent : Colors.green,
          ),
          onPressed: () {
            if (student.isActive) {
              controller.deactivateStudent(student.id);
            } else {
              controller.activateStudent(student.id);
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _showDeleteConfirmationDialog(context, student, controller);
          },
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Student student,
      StudentController studentController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text('Are you sure you want to delete ${student.name}?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                studentController.deleteStudent(student.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
