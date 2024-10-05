// lib/screens/class_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/controllers/class_controller.dart';
import 'package:school_web_app/models/class_model.dart';
import 'package:school_web_app/views/sidebars.dart';

// Custom InputFormatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class ClassListPage extends StatefulWidget {
  const ClassListPage({super.key});

  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  // Separate GlobalKeys for Add and Edit forms to avoid validation conflicts
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Define allowed class names as Roman numerals from I to XII and digits from 1 to 12
  final List<String> allowedClassNames = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI',
    'XII',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  // Method to show the Add Class popup
  void _showAddClassPopup(BuildContext context) {
    final TextEditingController classNameController = TextEditingController();
    final TextEditingController divisionController = TextEditingController(); // New Controller
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Class Name Field
                TextFormField(
                  controller: classNameController,
                  decoration: InputDecoration(
                    labelText: 'Class Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3), // Limit input to 3 characters
                    FilteringTextInputFormatter.allow(RegExp('[IVX0-9]')), // Allow I, V, X and digits 0-9
                    UpperCaseTextFormatter(), // Convert to uppercase
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the class name!';
                    }
                    if (!allowedClassNames.contains(value.trim())) {
                      return 'Class name must be a Roman numeral (I-XII) or a digit (1-12)!';
                    }
                    // Check for duplicate Class Name and Division combination
                    bool exists = classController.classes.any((c) =>
                        c.className.toUpperCase() ==
                            classNameController.text.trim().toUpperCase() &&
                        c.division.toUpperCase() ==
                            divisionController.text.trim().toUpperCase());
                    if (exists) {
                      return 'This Class and Division combination already exists!';
                    }
                    return null; // Validation passed
                  },
                ),
                SizedBox(height: 16),
                // Division Field
                TextFormField(
                  controller: divisionController, // New Division Field
                  decoration: InputDecoration(
                    labelText: 'Division',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1), // Limit input to 1 character
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')), // Allow only letters
                    UpperCaseTextFormatter(), // Convert to uppercase
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the division!';
                    }
                    if (!RegExp(r'^[A-Z]$').hasMatch(value.trim())) {
                      return 'Division must be a single uppercase letter (A-Z)!';
                    }
                    // Check for duplicate Class Name and Division combination
                    bool exists = classController.classes.any((c) =>
                        c.className.toUpperCase() ==
                            classNameController.text.trim().toUpperCase() &&
                        c.division.toUpperCase() ==
                            value.trim().toUpperCase());
                    if (exists) {
                      return 'This Class and Division combination already exists!';
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
                        // If the form is valid, add the class
                        classController.addClass(
                          classNameController.text.trim(),
                          divisionController.text.trim(), // Pass Division
                        );
                        classNameController.clear(); // Clear the text fields
                        divisionController.clear();
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
    final TextEditingController divisionController =
        TextEditingController(text: classItem.division); // New Controller
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
                // Class Name Field
                TextFormField(
                  controller: classNameController,
                  decoration: InputDecoration(
                    labelText: 'Class Name',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3), // Limit input to 3 characters
                    FilteringTextInputFormatter.allow(RegExp('[IVX0-9]')), // Allow I, V, X and digits 0-9
                    UpperCaseTextFormatter(), // Convert to uppercase
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the class name!';
                    }
                    if (!allowedClassNames.contains(value.trim())) {
                      return 'Class name must be a Roman numeral (I-XII) or a digit (1-12)!';
                    }
                    // Check for duplicate Class Name and Division combination excluding the current class
                    bool exists = classController.classes.any((c) =>
                        c.className.toUpperCase() ==
                            classNameController.text.trim().toUpperCase() &&
                        c.division.toUpperCase() ==
                            divisionController.text.trim().toUpperCase() &&
                        c != classItem);
                    if (exists) {
                      return 'This Class and Division combination already exists!';
                    }
                    return null; // Validation passed
                  },
                ),
                SizedBox(height: 16),
                // Division Field
                TextFormField(
                  controller: divisionController, // New Division Field
                  decoration: InputDecoration(
                    labelText: 'Division',
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.poppins(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1), // Limit input to 1 character
                    FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')), // Allow only letters
                    UpperCaseTextFormatter(), // Convert to uppercase
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the division!';
                    }
                    if (!RegExp(r'^[A-Z]$').hasMatch(value.trim())) {
                      return 'Division must be a single uppercase letter (A-Z)!';
                    }
                    // Check for duplicate Class Name and Division combination excluding the current class
                    bool exists = classController.classes.any((c) =>
                        c.className.toUpperCase() ==
                            classNameController.text.trim().toUpperCase() &&
                        c.division.toUpperCase() ==
                            value.trim().toUpperCase() &&
                        c != classItem);
                    if (exists) {
                      return 'This Class and Division combination already exists!';
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                        divisionController.text.trim(), // Pass Division
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  // Method to show the Delete Confirmation dialog
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
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            'Are you sure you want to delete the class "${classItem.className} - ${classItem.division}"?',
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
                  // Header "Classes"
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
                                    MediaQuery.of(context).size.width * 0.9, // Adjusted width
                                child: DataTable(
                                  columnSpacing: 20.0, // Adjust spacing as needed
                                  headingRowColor: MaterialStateProperty.all(
                                      Colors.blueGrey.shade900),
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'Class ID', // Changed from 'Serial No' to 'Class ID'
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
                                        'Division', // New Division Column
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
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            DataCell(Container()), // Empty Division Cell
                                            DataCell(Container()),
                                          ])
                                        ]
                                      : List<DataRow>.generate(
                                          classController.classes.length,
                                          (index) {
                                            final classItem =
                                                classController.classes[index];
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 12.0),
                                                    child: Text(
                                                        classItem.id.toString()), // Display Class ID
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 12.0),
                                                    child:
                                                        Text(classItem.className),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 12.0),
                                                    child: Text(
                                                        classItem.division), // Display Division
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 12.0),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors.blueAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showEditClassPopup(
                                                                context,
                                                                index,
                                                                classItem);
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.redAccent,
                                                          ),
                                                          onPressed: () {
                                                            _showDeleteConfirmationDialog(
                                                                context,
                                                                index,
                                                                classItem);
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
