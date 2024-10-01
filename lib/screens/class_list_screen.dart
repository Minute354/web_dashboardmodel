// lib/screens/class_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/class_controller.dart';
import 'package:school_web_app/models/class_model.dart';
import 'package:school_web_app/screens/sidebars.dart';
import 'dashboard_screen.dart';

class ClassListPage extends StatefulWidget {
  const ClassListPage({super.key});

  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  // Separate GlobalKeys for Add and Edit forms to avoid validation conflicts
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Method to show the Add Class popup
  void _showAddClassPopup(BuildContext context) {
    final TextEditingController classNameController = TextEditingController();
    final classController = Provider.of<ClassController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Class',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _addFormKey, // Assign the GlobalKey to the Form
            child: TextFormField(
              controller: classNameController,
              decoration: InputDecoration(
                labelText: 'Class Name',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the class name!';
                }
                // Check for duplicate class names
                bool exists = classController.classes.any((c) =>
                    c.className.toLowerCase() ==
                    value.trim().toLowerCase());
                if (exists) {
                  return 'Class name already exists!';
                }
                return null; // Validation passed
              },
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
                        // If the form is valid, add the class
                        classController.addClass(
                          classNameController.text.trim(),
                        );
                        classNameController.clear(); // Clear the text field
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
                      'Add Class',
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

  // Method to show the Edit Class popup
  void _showEditClassPopup(
      BuildContext context, int index, ClassModel classItem) {
    final TextEditingController classNameController =
        TextEditingController(text: classItem.className);
    final classController =
        Provider.of<ClassController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Class',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _editFormKey, // Assign the GlobalKey to the Form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: classNameController,
                  decoration: InputDecoration(
                    labelText: 'Class Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the class name!';
                    }
                    // Check for duplicate class names excluding the current class
                    bool exists = classController.classes.any((c) =>
                        c.className.toLowerCase() ==
                            value.trim().toLowerCase() &&
                        c != classItem);
                    if (exists) {
                      return 'Class name already exists!';
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
                      // If the form is valid, update the class
                      classController.updateClass(
                        index,
                        classNameController.text.trim(),
                      );
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
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
  void _showDeleteConfirmationDialog(
      BuildContext context, int index, ClassModel classItem) {
    final classController =
        Provider.of<ClassController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Class',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            'Are you sure you want to delete the class "${classItem.className}"?',
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
                    classController.removeClass(index);
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
          'Class List', // Updated title for clarity
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
                  // Header "Class"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Classes',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddClassPopup(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Class'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Consumer<ClassController>(
                      builder: (context, classController, child) {
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
                                        'Serial No',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Class Name',
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
                                  rows: classController.classes.isEmpty
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
                                          classController.classes.length,
                                          (index) {
                                            final classItem = classController.classes[index];
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
                                                    child: Text(classItem.className),
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
                                                            _showEditClassPopup(context, index, classItem);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.redAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showDeleteConfirmationDialog(context, index, classItem);
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
