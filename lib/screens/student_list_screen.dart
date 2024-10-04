// lib/screens/student_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/student_controller.dart';
import 'package:school_web_app/models/student_model.dart';
import 'package:school_web_app/screens/sidebars.dart';
import 'add_student_screen.dart';
import 'edit_student.dart';

class StudentListPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is small based on width
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Student Management',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // Drawer for small screens
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          // Sidebar for larger screens, occupying 16% of the screen width
          if (!isSmallScreen)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16, // 16% width
              child: Sidebar(),
            ),
          // Main content area occupying the remaining 84%
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align children to the left
                children: [
                  // Header "Students"
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
                  // Add Student button aligned to the right
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AddStudentPage()),
                          );
                        },
                        icon: Icon(
                          Icons.add, // Add icon
                          color: Colors.blue, // Icon color
                        ),
                        label: Text(
                          'Add Student',
                          style: GoogleFonts.poppins(
                            color: Colors.blue, // Text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Search TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        // Search input field
                        Expanded(
                          child: TextField(
                            controller:
                                _searchController, // Add a controller to get the text value
                            decoration: InputDecoration(
                              labelText: 'Search by name',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Call the filter method as the user types
                               
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        // Search button
                       
                      ],
                    ),
                  ),

                  // Student list in table format
                  Expanded(
                    child: Consumer<StudentController>(
                      builder: (context, studentController, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.75, // 75% width
                            child: DataTable(
                              columnSpacing: 20.0, // Adjust spacing as needed
                              headingRowColor:
                                  MaterialStateProperty.all(Colors.blueGrey.shade900),
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
                              rows: [
                                // Fixed First Row (Always Visible)

                                // Dynamically generate student rows
                                ...List<DataRow>.generate(
                                  studentController.students.length,
                                  (index) {
                                    final student =
                                        studentController.students[index];
                                    return DataRow(
                                      cells: <DataCell>[
                                        // Serial Number Cell
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                            child: Text(
                                              '${index + 1}', // Starts from 1
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        // Name Cell
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                            child: Text(
                                              student.name,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        // Class Cell
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                            child: Text(
                                              student.studentClass,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        // Division Cell
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 12.0),
                                            child: Text(
                                              student.division,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        // Status Cell
                                        DataCell(
                                          SizedBox(width: 100,
                                            child: Chip(
                                              label: Text(
                                                student.isActive
                                                    ? 'Active'
                                                    : 'Inactive',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: student.isActive
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                        // Actions Cell
                                        DataCell(
                                          _buildActionButtons(context, student,
                                              studentController),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
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

  // Helper method to build action buttons
  Widget _buildActionButtons(
      BuildContext context, Student? student, StudentController controller) {
    if (student == null) {
      // Actions for the fixed first row (if any)
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // You can customize actions for the fixed row here if needed
          Icon(Icons.info, color: Colors.grey),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blueAccent),
          tooltip: 'Edit Student',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditStudentPage(student: student),
              ),
            );
          },
        ),
        SizedBox(
          child: IconButton(
            icon: Icon(
              student.isActive ? Icons.cancel : Icons.check_circle,
              color: student.isActive ? Colors.redAccent : Colors.green,
            ),
            tooltip: student.isActive ? 'Deactivate Student' : 'Activate Student',
            onPressed: () {
              if (student.isActive) {
                controller.deactivateStudent(student.id);
              } else {
                controller.activateStudent(student.id);
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          tooltip: 'Delete Student',
          onPressed: () {
            _showDeleteConfirmationDialog(context, student, controller);
          },
        ),
      ],
    );
  }

  // Helper method to show the Delete Confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, Student student,
      StudentController studentController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Student',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to delete the student "${student.name}"?',
            style: TextStyle(),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    studentController.deleteStudent(student.id);
                    Navigator.of(context).pop(); // Close the dialog
                    // Show SnackBar feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Student "${student.name}" deleted successfully!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
