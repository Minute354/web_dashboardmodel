// lib/screens/division_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/views/sidebars.dart';
import '../controllers/division_controller.dart';
import '../models/division_model.dart';

// Custom InputFormatter to convert input to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class DivisionListPage extends StatefulWidget {
  const DivisionListPage({super.key});

  @override
  _DivisionListPageState createState() => _DivisionListPageState();
}

class _DivisionListPageState extends State<DivisionListPage> {
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Method to show the Add Division popup
  void _showAddDivisionPopup(BuildContext context) {
    final TextEditingController divisionNameController = TextEditingController();
    final divisionController = Provider.of<DivisionController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Division',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _addFormKey,
            child: TextFormField(
              controller: divisionNameController,
              decoration: InputDecoration(
                labelText: 'Division Name',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(),
              inputFormatters: [
                // Allow only uppercase letters
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                LengthLimitingTextInputFormatter(2), // Limit to 2 characters if needed
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the division name!';
                }
                // Check if it contains only uppercase alphabets
                if (!RegExp(r'^[A-Z]+$').hasMatch(value.trim())) {
                  return 'Division name must contain only uppercase alphabets!';
                }
                bool exists = divisionController.divisions.any((d) =>
                    d.divisionName.toUpperCase() == value.trim().toUpperCase());
                if (exists) {
                  return 'Division name already exists!';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.redAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
                  if (_addFormKey.currentState!.validate()) {
                    divisionController.addDivision(
                      divisionNameController.text.trim().toUpperCase(),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                    // Show SnackBar feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Division added successfully!')),
                    );
                  }
                },
                child: Text(
                  'Add Division',
                  style: GoogleFonts.poppins(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to show the Edit Division popup
  void _showEditDivisionPopup(BuildContext context, int index, DivisionModel divisionItem) {
    final TextEditingController divisionNameController =
        TextEditingController(text: divisionItem.divisionName);
    final divisionController = Provider.of<DivisionController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Division',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _editFormKey,
            child: TextFormField(
              controller: divisionNameController,
              decoration: InputDecoration(
                labelText: 'Division Name',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(),
              inputFormatters: [
                // Allow only uppercase letters
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                LengthLimitingTextInputFormatter(2), // Limit to 2 characters if needed
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the division name!';
                }
                if (!RegExp(r'^[A-Z]+$').hasMatch(value.trim())) {
                  return 'Division name must contain only uppercase alphabets!';
                }
                bool exists = divisionController.divisions.any((d) =>
                    d.divisionName.toUpperCase() == value.trim().toUpperCase() &&
                    d != divisionItem);
                if (exists) {
                  return 'Division name already exists!';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_editFormKey.currentState!.validate()) {
                  divisionController.updateDivision(
                    index,
                    divisionNameController.text.trim().toUpperCase(),
                  );
                  Navigator.of(context).pop(); // Close the dialog
                  // Show SnackBar feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Division updated successfully!')),
                  );
                }
              },
              child: Text(
                'Save Changes',
                style: GoogleFonts.poppins(color: Colors.blueAccent),
              ),
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
          'Division List',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Row(
        children: [
          Sidebar(), // Your sidebar widget here
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
              children: [
                // Divisions title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Divisions',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Add Division button aligned to the right
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showAddDivisionPopup(context);
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
                        'Add Division',
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Expanded DataTable
                Expanded(
                  child: Consumer<DivisionController>(
                    builder: (context, divisionController, child) {
                      return divisionController.divisions.isEmpty
                          ? Center(
                              child: Text(
                                'No Divisions Added Yet.',
                                style: GoogleFonts.poppins(fontSize: 18),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding around the DataTable
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75, // 3/4 of the screen width
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columnSpacing: 20.0,
                                    headingRowColor: MaterialStateProperty.all(
                                      Colors.blueGrey.shade900,
                                    ),
                                    border: TableBorder.all(
                                      color: Colors.black,
                                      width: 2,
                                    ), // Thicker border for DataTable
                                    columns: [
                                      DataColumn(
                                        label: Padding(
                                          padding: const EdgeInsets.all(8.0), // Padding within header cells
                                          child: Text(
                                            'Serial No',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Division Name',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Actions',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List<DataRow>.generate(
                                      divisionController.divisions.length,
                                      (index) {
                                        final divisionItem = divisionController.divisions[index];
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.all(8.0), // Padding within cell
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  divisionItem.divisionName,
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: Colors.blueAccent,
                                                      ),
                                                      onPressed: () {
                                                        _showEditDivisionPopup(context, index, divisionItem);
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.redAccent,
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                'Confirm Deletion',
                                                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                              ),
                                                              content: Text(
                                                                'Are you sure you want to delete this division?',
                                                                style: GoogleFonts.poppins(),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop(); // Close the dialog
                                                                  },
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: GoogleFonts.poppins(color: Colors.blue),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    divisionController.removeDivision(index);
                                                                    Navigator.of(context).pop(); // Close the dialog
                                                                    // Show SnackBar feedback
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                      SnackBar(content: Text('Division deleted successfully!')),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    'Delete',
                                                                    style: GoogleFonts.poppins(color: Colors.redAccent),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
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
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
