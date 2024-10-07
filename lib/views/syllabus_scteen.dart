// pages/syllabus_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_web_app/views/sidebars.dart';
import '../controllers/syllabus_controller.dart';
import '../models/syllabus_model.dart';

class SyllabusPage extends StatefulWidget {
  @override
  _SyllabusPageState createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  final _formKey = GlobalKey<FormState>();
  String _syllabusId = '';
  String _content = '';
  String _downloadUrl = '';
  int? _currentSyllabusIndex; // Track the index of the current syllabus for editing

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

  void _showAddSyllabusDialog() {
    // Clear previous values
    _syllabusId = '';
    _content = '';
    _downloadUrl = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Syllabus'),
        content: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width-1000,
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Download URL'),
                  onSaved: (value) => _downloadUrl = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a download URL';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _addSyllabus,
            child: Text('Add Syllabus'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog without saving
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showEditSyllabusDialog(Syllabus syllabus, int index) {
    // Set the current syllabus values for editing
    _syllabusId = syllabus.syllabusId;
    _content = syllabus.content;
    _downloadUrl = syllabus.downloadUrl;
    _currentSyllabusIndex = index;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Syllabus'),
        content: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width-1000,
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Content'),
                  initialValue: _content,
                  maxLines: 5, // Allow multiple lines for content
                  onSaved: (value) => _content = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the syllabus content';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Download URL'),
                  initialValue: _downloadUrl,
                  onSaved: (value) => _downloadUrl = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a download URL';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _editSyllabus,
            child: Text('Update Syllabus'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog without saving
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteSyllabus(int index) {
    Provider.of<SyllabusController>(context, listen: false).deleteSyllabus(index);
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

    return formattedContent.toString().trim(); // Trim to remove any trailing spaces/newlines
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Syllabus Management',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Center(
              child: Consumer<SyllabusController>(
                builder: (context, syllabusController, child) {
                  if (syllabusController.syllabi.isEmpty) {
                    return ElevatedButton(
                      onPressed: _showAddSyllabusDialog,
                      child: Text('Add Syllabus'),
                    );
                  } else {
                    final lastSyllabus = syllabusController.syllabi.last;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container for Syllabus Information
                        Container(
                          width: MediaQuery.of(context).size.width-800,
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Background color for the status area
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Current Syllabus Status',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Syllabus ID Box
                              Container(
                                padding: EdgeInsets.all(15), // Increased padding
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(' ID: ${lastSyllabus.syllabusId}', style: TextStyle(fontSize: 16)), // Increased font size
                              ),
                              // Content Box
                              Container(
                                padding: EdgeInsets.all(15), // Increased padding
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('Content: \n${formatContent(lastSyllabus.content)}', style: TextStyle(fontSize: 16), textAlign: TextAlign.left), // Increased font size
                              ),
                              // Download URL Box
                              Container(
                                padding: EdgeInsets.all(15), // Increased padding
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('Download URL: \n ${lastSyllabus.downloadUrl}', style: TextStyle(fontSize: 16)), // Increased font size
                              ),
                              // Button Row
                              Align(
                                alignment: Alignment.bottomRight, // Align buttons to the bottom right
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _showEditSyllabusDialog(lastSyllabus, syllabusController.syllabi.length - 1),
                                      child: Text('Edit'),
                                    ),
                                    SizedBox(width: 10), // Space between buttons
                                    ElevatedButton(
                                      onPressed: () => _deleteSyllabus(syllabusController.syllabi.length - 1),
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
