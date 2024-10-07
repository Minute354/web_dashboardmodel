import 'package:flutter/material.dart';
import '../models/teacher_model.dart';
import '../controllers/teacher_controller.dart';
import 'package:provider/provider.dart';
import 'sidebars.dart';

class EditTeacherPage extends StatefulWidget {
  final Teacher teacher;

  EditTeacherPage({required this.teacher});

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  late String _firstName;
  late String _lastName;
  late String _subject;
  late String _email;
  late String _contactNo;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _firstName = widget.teacher.firstName;
    _lastName = widget.teacher.lastName;
    _subject = widget.teacher.subject;
    _email = widget.teacher.email;
    _contactNo = widget.teacher.contactNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Teacher',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Sidebar on the left
          Sidebar(),

          // Edit Teacher Details Form on the right
          Expanded(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Form Title
                              Center(
                                child: Text(
                                  'Edit Teacher Details',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),

                              // Row for First Name and Last Name
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'First Name',
                                      initialValue: _firstName,
                                      onSave: (value) {
                                        _firstName = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter first name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Last Name',
                                      initialValue: _lastName,
                                      onSave: (value) {
                                        _lastName = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter last name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              // Subject
                              _buildTextField(
                                label: 'Subject',
                                initialValue: _subject,
                                onSave: (value) {
                                  _subject = value!;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter subject';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),

                              // Email
                              _buildTextField(
                                label: 'Email',
                                initialValue: _email,
                                onSave: (value) {
                                  _email = value!;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),

                              // Contact Number
                              _buildTextField(
                                label: 'Contact No',
                                initialValue: _contactNo,
                                onSave: (value) {
                                  _contactNo = value!;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter contact number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone, // Ensure it's a phone number
                              ),
                              SizedBox(height: 40),

                              // Save Changes Button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      // Update the teacher in the controller
                                      Provider.of<TeacherController>(context, listen: false)
                                          .updateTeacher(
                                        Teacher(
                                          firstName: _firstName,
                                          lastName: _lastName,
                                          subject: _subject,
                                          email: _email,
                                          contactNo: _contactNo,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'Save Changes',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to create a text field
  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSave,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSave,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.text_fields, color: Colors.blueGrey.shade900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade900, width: 2),
        ),
      ),
    );
  }
}
