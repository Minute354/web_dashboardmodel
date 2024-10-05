import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/teacher_controller.dart';
import 'package:school_web_app/models/teacher_model.dart';

import 'add_teacher_screen.dart';
import 'edit_teacher.dart';
import 'sidebars.dart';

class TeacherListPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  TeacherListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Teacher Management',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              child: Sidebar(),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Teachers',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddTeacherPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Add Teacher',
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search by name',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              Provider.of<TeacherController>(context, listen: false)
                                  .filterTeachers(value);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Consumer<TeacherController>(
                      builder: (context, teacherController, child) {
                        List<Teacher> teachers = teacherController.filteredTeachers;

                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: DataTable(
                                columnSpacing: 20.0,
                                headingRowColor:
                                    WidgetStateProperty.all(Colors.blueGrey.shade900),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Teacher ID',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'First Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Last Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Subject',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Contact No',
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
                                  teachers.length,
                                  (index) {
                                    final teacher = teachers[index];
                                    return DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.id.toString(),
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.firstName,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.lastName,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.subject,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.email,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12.0),
                                            child: Text(
                                              teacher.contactNo,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(width: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                // Toggle the status
                                                teacherController.updateTeacherStatus(teacher.id, !teacher.isActive);
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white, backgroundColor: teacher.isActive ? Colors.green : Colors.red, // Text color
                                              ),
                                              child: Text(
                                                teacher.isActive ? 'Active' : 'Inactive',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          _buildActionButtons(context, teacher, teacherController),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
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

  Widget _buildActionButtons(BuildContext context, Teacher teacher, TeacherController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blueAccent),
          tooltip: 'Edit Teacher',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTeacherPage(teacher: teacher),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          tooltip: 'Delete Teacher',
          onPressed: () {
            _showDeleteConfirmationDialog(context, teacher, controller);
          },
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Teacher teacher, TeacherController teacherController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Teacher',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text('Are you sure you want to delete ${teacher.firstName} ${teacher.lastName}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                teacherController.deleteTeacher(teacher.id); // Call delete method
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
