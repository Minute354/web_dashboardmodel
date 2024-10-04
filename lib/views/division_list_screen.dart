// lib/screens/division_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/views/sidebars.dart';
import '../controllers/division_controller.dart';
import '../models/division_model.dart';

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
    final TextEditingController divisionNameController =
        TextEditingController();
    final divisionController =
        Provider.of<DivisionController>(context, listen: false);

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
                // Force input to uppercase letters only
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
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
                        divisionController.addDivision(
                          divisionNameController.text.trim(),
                        );
                        divisionNameController.clear(); // Clear the text field
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Add Division',
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

  // Method to show the Edit Division popup
  void _showEditDivisionPopup(
      BuildContext context, int index, DivisionModel divisionItem) {
    final TextEditingController divisionNameController =
        TextEditingController(text: divisionItem.divisionName);
    final divisionController =
        Provider.of<DivisionController>(context, listen: false);

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
                // Force input to uppercase letters only
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the division name!';
                }
                if (!RegExp(r'^[A-Z]+$').hasMatch(value.trim())) {
                  return 'Division name must contain only uppercase alphabets!';
                }
                bool exists = divisionController.divisions.any((d) =>
                    d.divisionName.toUpperCase() ==
                        value.trim().toUpperCase() &&
                    d != divisionItem);
                if (exists) {
                  return 'Division name already exists!';
                }
                return null;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                ),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.redAccent),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_editFormKey.currentState!.validate()) {
                  divisionController.updateDivision(
                      index, divisionNameController.text.trim().toUpperCase());
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              icon: Icon(
                Icons.save, // Add the save icon
                color: Colors.green,
              ),
              label: Text(
                'Save Changes',
                style: GoogleFonts.poppins(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Set the button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Add rounded corners
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // New method to show the Delete Confirmation dialog
  void _showDeleteConfirmationDialog(
      BuildContext context, int index, DivisionModel divisionItem) {
    final divisionController =
        Provider.of<DivisionController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Division',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            'Are you sure you want to delete the division "${divisionItem.divisionName}"?',
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
                    divisionController.removeDivision(index);
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divisions title
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Divisions',
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Add Division button aligned to the right
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddDivisionPopup(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Division'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Consumer<DivisionController>(
                      builder: (context, divisionController, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: DataTable(
                                  columnSpacing:
                                      20.0, // Adjust spacing as needed
                                  headingRowColor: MaterialStateProperty.all(
                                      Colors.blueGrey.shade900),
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
                                        'Division Name',
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
                                  rows: divisionController.divisions.isEmpty
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
                                          divisionController.divisions.length,
                                          (index) {
                                            final divisionItem =
                                                divisionController
                                                    .divisions[index];
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
                                                    child: Text(divisionItem
                                                        .divisionName),
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
                                                            _showEditDivisionPopup(
                                                                context,
                                                                index,
                                                                divisionItem);
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
                                                                divisionItem);
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
