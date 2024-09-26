import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _studentClass = '1'; // Default value for class
  String _parentName = '';
  String _division = 'A'; // Default value for division
  String _place = '';
  int _age = 0;
  String _gender = 'Male';

  // List of classes (1 to 12) generated dynamically
  final List<String> _classes = List.generate(12, (index) => (index + 1).toString());
  final List<String> _divisions = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Enter Student Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Student Name',
                    icon: Icons.person,
                    onSave: (value) => _name = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter student name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildDropdown(
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
                  SizedBox(height: 16),
                  _buildDropdown(
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
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Parent Name',
                    icon: Icons.people,
                    onSave: (value) => _parentName = value!,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Place',
                    icon: Icons.location_on,
                    onSave: (value) => _place = value!,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
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
                  SizedBox(height: 16),
                  _buildDropdown(
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
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text('Add Student'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Provider.of<StudentController>(context, listen: false).addStudent(
                            Student(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: _name,
                              studentClass: _studentClass,
                              division: _division,
                              parentName: _parentName,
                              place: _place,
                              age: _age,
                              gender: _gender,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
