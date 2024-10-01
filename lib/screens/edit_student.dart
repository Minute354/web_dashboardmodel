// views/edit_student_screen.dart
import 'package:flutter/material.dart';
import 'package:school_web_app/screens/sidebars.dart'; // Ensure the correct import path
import '../models/student_model.dart';
import '../controllers/student_controller.dart';
import 'package:provider/provider.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  EditStudentPage({required this.student});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  late String _firstName;
  late String _middleName;
  late String _lastName;
  late String _studentClass;
  late String _fatherName;
  late String _motherName;
  late String _division;
  late String _place;
  late String _address;
  late int _age;
  late String _gender;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    // Assuming the name is stored as 'First Middle Last'
    List<String> nameParts = widget.student.name.split(' ');
    _firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    _middleName = nameParts.length > 2 ? nameParts[1] : '';
    _lastName = nameParts.length > 1 ? nameParts.last : '';

    // Assuming parentName is stored as 'Father & Mother'
    List<String> parentParts = widget.student.parentName.split('&');
    _fatherName = parentParts.isNotEmpty ? parentParts[0].trim() : '';
    _motherName = parentParts.length > 1 ? parentParts[1].trim() : '';

    _studentClass = widget.student.studentClass;
    _division = widget.student.division;
    _address = widget.student.address;
    _place = widget.student.place;
    _age = widget.student.age;
    _gender = widget.student.gender;
    _isActive = widget.student.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Student',
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
          Sidebar(), // Ensure Sidebar has a fixed width or appropriate sizing

          // Edit Student Details Form on the right
          Expanded(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.95, // Adjust as needed for desired width
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Form Title
                              Center(
                                child: Text(
                                  'Edit Student Details',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ),
                              ),
                              SizedBox(height: 40), // Spacing after title

                              // First Row: First Name, Middle Name, Last Name (3 fields)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'First Name',
                                      icon: Icons.person,
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
                                      label: 'Middle Name',
                                      icon: Icons.person_outline,
                                      initialValue: _middleName,
                                      onSave: (value) {
                                        _middleName = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Last Name',
                                      icon: Icons.person_outline,
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
                              SizedBox(height: 20), // Spacing between rows

                              // Second Row: Class, Division (2 fields)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Class',
                                      icon: Icons.class_,
                                      initialValue: _studentClass,
                                      onSave: (value) {
                                        _studentClass = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter class';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Division',
                                      icon: Icons.group,
                                      initialValue: _division,
                                      onSave: (value) {
                                        _division = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Address',
                                      icon: Icons.location_on,
                                      initialValue: _address,
                                      onSave: (value) {
                                        _address = value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20), // Spacing between rows

                              // Third Row: Father's Name, Mother's Name (2 fields)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Father\'s Name',
                                      icon: Icons.person,
                                      initialValue: _fatherName,
                                      onSave: (value) {
                                        _fatherName = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter father\'s name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Mother\'s Name',
                                      icon: Icons.person,
                                      initialValue: _motherName,
                                      onSave: (value) {
                                        _motherName = value!;
                                      },
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
                              SizedBox(height: 20), // Spacing between rows

                              // Fourth Row: Place, Age, Gender (3 fields)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Place',
                                      icon: Icons.location_on,
                                      initialValue: _place,
                                      onSave: (value) {
                                        _place = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Age',
                                      icon: Icons.calendar_today,
                                      keyboardType: TextInputType.number,
                                      initialValue: _age.toString(),
                                      onSave: (value) {
                                        _age = int.parse(value!);
                                      },
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
                                  SizedBox(width: 20), // Spacing between fields
                                  Expanded(
                                    child: _buildGenderDropdown(
                                      initialValue: _gender,
                                      onSave: (value) {
                                        _gender = value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20), // Spacing between rows

                              // Fifth Row: Is Active Switch (1 field)
                              Row(
                                children: [
                                  Expanded(
                                    child: SwitchListTile(
                                      
                                      title: Text('Is Active'),
                                      value: _isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          _isActive = value;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading, // Position the switch before the text
                                      activeColor: Colors.green,
                                      inactiveThumbColor: Colors.red,
                                      inactiveTrackColor: Colors.red[200],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40), // Spacing before the button

                              // Save Changes Button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Provider.of<StudentController>(context, listen: false)
                                          .updateStudent(
                                        widget.student.id,
                                        Student(
                                          id: widget.student.id,
                                          name: '$_firstName $_middleName $_lastName',
                                          studentClass: _studentClass,
                                          division: _division,
                                          parentName: '$_fatherName & $_motherName',
                                          place: _place,
                                          age: _age,
                                          gender: _gender,
                                          isActive: _isActive, address: "",
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
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
    required IconData icon,
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
        prefixIcon: Icon(icon, color: Colors.blueGrey.shade900),
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

  // Method for the gender dropdown
  Widget _buildGenderDropdown({
    required String initialValue,
    required FormFieldSetter<String> onSave,
  }) {
    return DropdownButtonFormField<String>(
      value: initialValue.isNotEmpty ? initialValue : null,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(Icons.transgender, color: Colors.blueGrey.shade900),
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
      items: [
        DropdownMenuItem(
          value: 'Male',
          child: Text('Male'),
        ),
        DropdownMenuItem(
          value: 'Female',
          child: Text('Female'),
        ),
      ],
      onChanged: (value) {},
      onSaved: onSave,
      validator: (value) {
        if (value == null) {
          return 'Please select gender';
        }
        return null;
      },
    );
  }
}
