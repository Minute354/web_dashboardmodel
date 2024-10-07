// lib/views/add_teacher_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/teacher_controller.dart';
import '../models/teacher_model.dart';
import 'sidebars.dart';
import 'package:email_validator/email_validator.dart';

class AddTeacherPage extends StatefulWidget {
  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _subject = '';
  String _email = '';
  String _contactNo = '';

  final Color primaryColor = Colors.blueGrey.shade900;
  final Color secondaryColor = Colors.blueGrey.shade900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Teacher',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Enter Teacher Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'First Name',
                                icon: Icons.person,
                                onSave: (value) => _firstName = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Last Name',
                                icon: Icons.person_outline,
                                onSave: (value) => _lastName = value!,
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
                        SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'Subject',
                                icon: Icons.subject,
                                onSave: (value) => _subject = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter subject';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Email',
                                icon: Icons.email,
                                onSave: (value) => _email = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        _buildTextField(
                          label: 'Contact No',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          onSave: (value) => _contactNo = value!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Contact number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),

                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.check, color: Colors.white),
                            label: Text('Add Teacher', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Provider.of<TeacherController>(context, listen: false).addTeacher(
                                  Teacher(
                                    firstName: _firstName,
                                    lastName: _lastName,
                                    subject: _subject,
                                    email: _email,
                                    contactNo: _contactNo,
                                  ),
                                );
                                Navigator.of(context).pop(); // Go back after adding
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: primaryColor,
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
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSave,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSave,
    );
  }
}
