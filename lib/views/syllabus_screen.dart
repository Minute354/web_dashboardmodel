// lib/screens/syllabus_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/syllabus_controller.dart';
import '../models/syllabus_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sidebars.dart';

class SyllabusPage extends StatefulWidget {
  @override
  _SyllabusPageState createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  final _formKey = GlobalKey<FormState>();
  String _syllabusId = '';
  String _content = '';
  String _downloadUrl = '';
  int?
      _currentSyllabusIndex; // Track the index of the current syllabus for editing

  // Method to add a new syllabus
  void _addSyllabus() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new syllabus and add it
      Syllabus newSyllabus = Syllabus(
        syllabusId: _syllabusId,
        content: _content,
        downloadUrl: _downloadUrl,
      );

      Provider.of<SyllabusController>(context, listen: false)
          .addSyllabus(newSyllabus);

      Navigator.of(context).pop(); // Close dialog
      setState(() {}); // Refresh the page
    }
  }

  // Method to edit an existing syllabus
  void _editSyllabus() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Update the current syllabus
      Syllabus updatedSyllabus = Syllabus(
        syllabusId: _syllabusId,
        content: _content,
        downloadUrl: _downloadUrl,
      );

      Provider.of<SyllabusController>(context, listen: false)
          .updateSyllabus(_currentSyllabusIndex!, updatedSyllabus);

      Navigator.of(context).pop(); // Close dialog
      setState(() {}); // Refresh the page
    }
  }

  // Method to show the Add Syllabus dialog
  void _showAddSyllabusDialog() {
    // Clear previous values
    _syllabusId = '';
    _content = '';
    _downloadUrl = '';
    _currentSyllabusIndex = null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Syllabus',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Ensure the dialog is scrollable if content overflows
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Syllabus ID'),
                    onSaved: (value) => _syllabusId = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a syllabus ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content'),
                    maxLines: 5, // Allow multiple lines for content
                    onSaved: (value) => _content = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the syllabus content';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Download URL'),
                    onSaved: (value) => _downloadUrl = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a download URL';
                      }
                      // Validate URL format
                      final urlPattern =
                          r'^(http|https):\/\/([\w\-]+\.)+[\w\-]+(\/[\w\-\.]*)*$';
                      final result = RegExp(urlPattern, caseSensitive: false)
                          .firstMatch(value);
                      if (result == null) {
                        return 'Please enter a valid URL';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _addSyllabus,
            child: Text(
              'Add Syllabus',
              style: GoogleFonts.poppins(color: Colors.blueGrey.shade900),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // Close dialog without saving
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the Edit Syllabus dialog
  void _showEditSyllabusDialog(Syllabus syllabus, int index) {
    // Set the current syllabus values for editing
    _syllabusId = syllabus.syllabusId;
    _content = syllabus.content;
    _downloadUrl = syllabus.downloadUrl;
    _currentSyllabusIndex = index;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Syllabus',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Ensure the dialog is scrollable if content overflows
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Syllabus ID'),
                    initialValue: _syllabusId,
                    onSaved: (value) => _syllabusId = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a syllabus ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content'),
                    initialValue: _content,
                    maxLines: 5,
                    onSaved: (value) => _content = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the syllabus content';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Download URL'),
                    initialValue: _downloadUrl,
                    onSaved: (value) => _downloadUrl = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a download URL';
                      }
                      // Validate URL format
                      final urlPattern =
                          r'^(http|https):\/\/([\w\-]+\.)+[\w\-]+(\/[\w\-\.]*)*$';
                      final result = RegExp(urlPattern, caseSensitive: false)
                          .firstMatch(value);
                      if (result == null) {
                        return 'Please enter a valid URL';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _editSyllabus,
            child: Text(
              'Update Syllabus',
              style: GoogleFonts.poppins(color: Colors.blueGrey.shade900),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // Close dialog without saving
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  // Method to delete a syllabus
  void _deleteSyllabus(int index) {
    Provider.of<SyllabusController>(context, listen: false)
        .deleteSyllabus(index);
    setState(() {}); // Refresh the page
  }

  // Helper function to format content to max 75 characters per line
  String formatContent(String content) {
    final List<String> words = content.split(' ');
    StringBuffer formattedContent = StringBuffer();
    String line = '';

    for (String word in words) {
      if ((line + word).length <= 75) {
        line += (line.isEmpty ? '' : ' ') + word;
      } else {
        formattedContent.writeln(line);
        line = word; // Start a new line with the current word
      }
    }

    // Add any remaining line
    if (line.isNotEmpty) {
      formattedContent.writeln(line);
    }

    return formattedContent
        .toString()
        .trim(); // Trim to remove any trailing spaces/newlines
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
          if (!isSmallScreen) Sidebar(), // Your sidebar widget here
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<SyllabusController>(
                builder: (context, syllabusController, child) {
                  bool isEmpty = syllabusController.syllabi.isEmpty;
                  return Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Stretch to fill width
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Syllabus',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Show "Add Syllabus" button only if the syllabi list is empty
                      if (isEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _showAddSyllabusDialog,
                              icon: Icon(Icons.add),
                              label: Text('Add Syllabus'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade900,
                                foregroundColor: Colors.white, // Text color
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      // Main Content Area
                      Expanded(
                        child: isEmpty
                            ? Center(
                                child: Text(
                                  'No syllabus are exist.',
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.5, // 3/4 of the screen width
                                    padding: EdgeInsets.all(16.0),
                                    margin:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[
                                          200], // Background color for the status area
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 8.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Current Syllabus Status',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        // Syllabus ID Box
                                        Container(
                                          padding: EdgeInsets.all(
                                              15), // Increased padding
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[100],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'ID: ${syllabusController.syllabi.last.syllabusId}',
                                            style: TextStyle(fontSize: 16),
                                          ), // Increased font size
                                        ),
                                        // Content Box
                                        Container(
                                          padding: EdgeInsets.all(
                                              15), // Increased padding
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[100],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Content: \n${formatContent(syllabusController.syllabi.last.content)}',
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.left,
                                          ), // Increased font size
                                        ),
                                        // Download URL Box
                                        Container(
                                          padding: EdgeInsets.all(
                                              15), // Increased padding
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[100],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Download URL: \n${syllabusController.syllabi.last.downloadUrl}',
                                            style: TextStyle(fontSize: 16),
                                          ), // Increased font size
                                        ),
                                        // Button Row
                                        Align(
                                          alignment: Alignment
                                              .bottomRight, // Align buttons to the bottom right
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    _showEditSyllabusDialog(
                                                        syllabusController
                                                            .syllabi.last,
                                                        syllabusController
                                                                .syllabi
                                                                .length -
                                                            1),
                                                child: Text('Edit'),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      10), // Space between buttons
                                              ElevatedButton(
                                                onPressed: () =>
                                                    _deleteSyllabus(
                                                        syllabusController
                                                                .syllabi
                                                                .length -
                                                            1),
                                                child: Text('Delete'),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
