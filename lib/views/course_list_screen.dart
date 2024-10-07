// lib/screens/course_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/course_controller.dart';
import 'package:school_web_app/models/course_model.dart';
import 'package:school_web_app/views/sidebars.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  // Separate GlobalKeys for Add and Edit forms to avoid validation conflicts
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Method to show the Add Course popup
  void _showAddCoursePopup(BuildContext context) {
    final TextEditingController courseNameController = TextEditingController();
    final courseController = Provider.of<CourseController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Course',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _addFormKey, // Assign the GlobalKey to the Form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the course name!';
                    }
                    // Check for duplicate course names
                    bool exists = courseController.courses.any((c) =>
                        c.courseName.toLowerCase() == value.trim().toLowerCase());
                    if (exists) {
                      return 'Course name already exists!';
                    }
                    return null; // Validation passed
                  },
                ),
              ],
            ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_addFormKey.currentState!.validate()) {
                        // If the form is valid, add the course
                        String newCourseName = courseNameController.text.trim();
                        courseController.addCourse(newCourseName);
                        courseNameController.clear(); // Clear the text field
                        Navigator.of(context).pop(); // Close the dialog
                        // Show SnackBar feedback
                       
                      }
                      // If the form is invalid, the validator will display error messages
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Add Course',
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
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
              ],
            ),
          ],
        );
      },
    );
  }

  // Method to show the Edit Course popup
  void _showEditCoursePopup(BuildContext context, int index, CourseModel courseItem) {
    final TextEditingController courseNameController =
        TextEditingController(text: courseItem.courseName);
    final courseController = Provider.of<CourseController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Course',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _editFormKey, // Assign the GlobalKey to the Form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the course name!';
                    }
                    // Check for duplicate course names excluding the current course
                    bool exists = courseController.courses.any((c) =>
                        c.courseName.toLowerCase() == value.trim().toLowerCase() && c != courseItem);
                    if (exists) {
                      return 'Course name already exists!';
                    }
                    return null; // Validation passed
                  },
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_editFormKey.currentState!.validate()) {
                      // If the form is valid, update the course
                      String updatedCourseName = courseNameController.text.trim();
                      courseController.updateCourse(index, updatedCourseName);
                      Navigator.of(context).pop(); // Close the dialog
                      // Show SnackBar feedback
                      
                    }
                    // If the form is invalid, the validator will display error messages
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                  label: Text(
                    'Save Changes',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // New method to show the Delete Confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, int index, CourseModel courseItem) {
    final courseController = Provider.of<CourseController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Course',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            'Are you sure you want to delete the course "${courseItem.courseName}"?',
            style: GoogleFonts.poppins(),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    courseController.deleteCourse(index);
                    Navigator.of(context).pop(); // Close the dialog
                    // Show SnackBar feedback
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course List', // Updated title for clarity
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Row(
        children: [
          Sidebar(), // Sidebar remains intact
          Expanded(
            child: Padding(
              // Added padding for the entire content area
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align children to the left
                children: [
                  // Header "Course"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Course',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Add Course button aligned to the right
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddCoursePopup(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Expanded DataTable wrapped in a Container
                  Expanded(
                    child: Consumer<CourseController>(
                      builder: (context, courseController, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.75,
                                child: DataTable(
                                  columnSpacing: 20.0, // Adjust spacing as needed
                                  headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade900),
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'Sl. No.',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Course Name',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Actions',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: courseController.courses.isEmpty
                                      ? [
                                          DataRow(cells: [
                                            DataCell(Container()),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  'No Records Yet.',
                                                  style: GoogleFonts.poppins(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            DataCell(Container()),
                                          ])
                                        ]
                                      : List<DataRow>.generate(
                                          courseController.courses.length,
                                          (index) {
                                            final courseItem = courseController.courses[index];
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                                    child: Text((index + 1).toString()),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                                    child: Text(courseItem.courseName),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors.blueAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showEditCoursePopup(context, index, courseController.courses[index]);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.redAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showDeleteConfirmationDialog(context, index, courseController.courses[index]);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
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
}
