// lib/screens/subject_list_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/subject_controller.dart';
import 'package:school_web_app/models/subject_model.dart';
import 'package:school_web_app/views/back_button.dart';
import 'package:school_web_app/views/dashboard_screen.dart';
import 'package:school_web_app/views/sidebars.dart';

class SubjectListPage extends StatefulWidget {
  const SubjectListPage({super.key});

  @override
  _SubjectListPageState createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Method to show the Add Subject popup
  void _showAddSubjectPopup(BuildContext context) {
    final TextEditingController subjectNameController = TextEditingController();
    final subjectController =
        Provider.of<SubjectController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Subject',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _addFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: subjectNameController,
                  decoration: InputDecoration(
                    labelText: 'Subject Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the subject name!';
                    }
                    // Check if the input contains only alphabets
                    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter only alphabetic characters!';
                    }
                    bool exists = subjectController.subjects.any((s) =>
                        s.subjectName.toLowerCase() ==
                        value.trim().toLowerCase());
                    if (exists) {
                      return 'Subject name already exists!';
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
                        subjectController.addSubject(
                          subjectNameController.text.trim(),
                        );
                        subjectNameController.clear(); // Clear the text field
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.blueGrey.shade900,
                    ),
                    label: Text(
                      'Add Subject',
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
              ],
            ),
          ],
        );
      },
    );
  }

  // Method to show the Edit Subject popup
  void _showEditSubjectPopup(
      BuildContext context, int index, SubjectModel subjectItem) {
    final TextEditingController subjectNameController =
        TextEditingController(text: subjectItem.subjectName);
    final subjectController =
        Provider.of<SubjectController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Subject',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _editFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: subjectNameController,
                  decoration: InputDecoration(
                    labelText: 'Subject Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the subject name!';
                    }
                    // Check if the input contains only alphabets
                    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter only alphabetic characters!';
                    }
                    // Check for duplicate subject names excluding the current subject
                    bool exists = subjectController.subjects.any((s) =>
                        s.subjectName.toLowerCase() ==
                            value.trim().toLowerCase() &&
                        s != subjectItem);
                    if (exists) {
                      return 'Subject name already exists!';
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
                      subjectController.updateSubject(
                        index,
                        subjectNameController.text.trim(),
                      );
                      Navigator.of(context).pop(); // Close the dialog
                    }
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
      BuildContext context, int index, SubjectModel subjectItem) {
    final subjectController =
        Provider.of<SubjectController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Subject',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            'Are you sure you want to delete the subject "${subjectItem.subjectName}"?',
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
                    subjectController.deleteSubject(index);
                    Navigator.of(context).pop(); // Close the dialog
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
     final isSmallScreen = MediaQuery.of(context).size.width < 800; // Check if it's mobile
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
         automaticallyImplyLeading:isSmallScreen?true: false,
      ),
       drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(), // Only show Sidebar on larger screens
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BackBtn(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => DashboardPage()),
                          );
                        },
                      ),
                    ],
                  ),
                  // Header "Subject"
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Subject',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Add Subject button aligned to the right
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddSubjectPopup(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Subject'),
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
                    child: Consumer<SubjectController>(
                      builder: (context, SubjectController, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: DataTable(
                                  columnSpacing:
                                      20.0, // Adjust spacing as needed
                                  headingRowColor: WidgetStateProperty.all(
                                      Colors.blueGrey.shade900),
                                       border: TableBorder.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ), // Thicker border for DataTable
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
                                        'Subject Name',
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
                                  rows: SubjectController.subjects.isEmpty
                                      ? [
                                          DataRow(cells: [
                                            DataCell(Container()),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  'No Records Yet.',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            DataCell(Container()),
                                          ])
                                        ]
                                      : List<DataRow>.generate(
                                          SubjectController.subjects.length,
                                          (index) {
                                            final subjectItem =
                                                SubjectController
                                                    .subjects[index];
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 12.0),
                                                    child: Text(
                                                        (index + 1).toString()),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 12.0),
                                                    child: Text(subjectItem
                                                        .subjectName),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 12.0),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showEditSubjectPopup(
                                                                context,
                                                                index,
                                                                subjectItem);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showDeleteConfirmationDialog(
                                                                context,
                                                                index,
                                                                subjectItem);
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
