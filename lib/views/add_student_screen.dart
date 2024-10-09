import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import 'sidebars.dart'; // Import your Sidebar widget

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  String _studentClass = '1'; // Default value for class
  String _division = 'A'; // Default value for division
  String _fathersName = '';
  String _mothersName = '';
  String _place = '';
  int _age = 0;
  String _gender = 'Male';
  String _address = '';

  // List of classes (1 to 12) generated dynamically
  final List<String> _classes = List.generate(12, (index) => (index + 1).toString());
  final List<String> _divisions = ['A', 'B', 'C', 'D', 'E'];

  // Define your color theme
  final Color primaryColor = Colors.blueGrey.shade900;
  final Color secondaryColor = Colors.blueGrey.shade900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        elevation: 0,
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: Row(
        children: [
          Sidebar(), // Add the sidebar here
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
                          'Enter Student Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40), // Increased spacing after the title

                        // First Row: First Name, Middle Name, Last Name
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
                                label: 'Middle Name',
                                icon: Icons.person_outline,
                                onSave: (value) => _middleName = value!,
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
                        SizedBox(height: 24), // Increased vertical spacing between rows

                        // Second Row: Class, Division, Address
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                label: 'Class',
                                value: _studentClass,
                                icon: Icons.school,
                                items: _classes,
                                onChanged: (newValue) {
                                  setState(() {
                                    _studentClass = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Division',
                                value: _division,
                                icon: Icons.group,
                                items: _divisions,
                                onChanged: (newValue) {
                                  setState(() {
                                    _division = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Address',
                                icon: Icons.location_on,
                                onSave: (value) => _address = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24), // Increased vertical spacing between rows

                        // Third Row: Father's Name, Mother's Name
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'Father\'s Name',
                                icon: Icons.people,
                                onSave: (value) => _fathersName = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter father\'s name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Mother\'s Name',
                                icon: Icons.people,
                                onSave: (value) => _mothersName = value!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mother\'s name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24), // Increased vertical spacing between rows

                        // Fourth Row: Place, Age, Gender
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'Place',
                                icon: Icons.location_on,
                                onSave: (value) => _place = value!,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Age',
                                icon: Icons.calendar_today,
                                keyboardType: TextInputType.number,
                                onSave: (value) => _age = int.parse(value!),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter age';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Gender',
                                value: _gender,
                                icon: Icons.transgender,
                                items: ['Male', 'Female'],
                                onChanged: (newValue) {
                                  setState(() {
                                    _gender = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40), // Increased spacing before the Add Student button

                        // Add Student Button
                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.check, color: Colors.white),
                            label: Text('Add Student', style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Provider.of<StudentController>(context, listen: false).addStudent(
                                  Student(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    name: '$_firstName $_middleName $_lastName',
                                    studentClass: _studentClass,
                                    division: _division,
                                    parentName: '$_fathersName & $_mothersName',
                                    place: _place,
                                    age: _age,
                                    gender: _gender,
                                    address: _address,
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
                              backgroundColor: primaryColor, // Change button color
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

  


  // Helper method for text fields
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
        prefixIcon: Icon(icon, color: primaryColor), // Change icon color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200], // Light background for the text fields
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey), // Default border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade900, width: 2), // Focused border color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2), // Error border color
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

  // Helper method for dropdown fields
  Widget _buildDropdown({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor), // Change icon color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200], // Light background for dropdown
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: secondaryColor)), // Match dropdown item text color
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}