import 'package:flutter/material.dart';
import 'package:school_web_app/views/sidebars.dart'; 
import '../models/student_model.dart';
import '../controllers/student_controller.dart';
import 'package:provider/provider.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  EditStudentPage({Key? key, required this.student}) : super(key: key);

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
    List<String> nameParts = widget.student.name.split(' ');
    _firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    _middleName = nameParts.length > 2 ? nameParts[1] : '';
    _lastName = nameParts.length > 1 ? nameParts.last : '';

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
        title: const Text('Edit Student'),
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
      ),
      body: Row(
        children: [
          Sidebar(),
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
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'First Name',
                                      icon: Icons.person,
                                      initialValue: _firstName,
                                      onSave: (value) => _firstName = value!,
                                      validator: (value) => value == null || value.isEmpty ? 'Please enter first name' : null,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Middle Name',
                                      icon: Icons.person_outline,
                                      initialValue: _middleName,
                                      onSave: (value) => _middleName = value!,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Last Name',
                                      icon: Icons.person_outline,
                                      initialValue: _lastName,
                                      onSave: (value) => _lastName = value!,
                                      validator: (value) => value == null || value.isEmpty ? 'Please enter last name' : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Class',
                                      icon: Icons.class_,
                                      initialValue: _studentClass,
                                      onSave: (value) => _studentClass = value!,
                                      validator: (value) => value == null || value.isEmpty ? 'Please enter class' : null,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Division',
                                      icon: Icons.group,
                                      initialValue: _division,
                                      onSave: (value) => _division = value!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Address',
                                      icon: Icons.location_on,
                                      initialValue: _address,
                                      onSave: (value) => _address = value!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Father\'s Name',
                                      icon: Icons.person,
                                      initialValue: _fatherName,
                                      onSave: (value) => _fatherName = value!,
                                      validator: (value) => value == null || value.isEmpty ? 'Please enter father\'s name' : null,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Mother\'s Name',
                                      icon: Icons.person,
                                      initialValue: _motherName,
                                      onSave: (value) => _motherName = value!,
                                      validator: (value) => value == null || value.isEmpty ? 'Please enter mother\'s name' : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Place',
                                      icon: Icons.location_on,
                                      initialValue: _place,
                                      onSave: (value) => _place = value!,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      label: 'Age',
                                      icon: Icons.calendar_today,
                                      keyboardType: TextInputType.number,
                                      initialValue: _age.toString(),
                                      onSave: (value) => _age = int.parse(value!),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Please enter age';
                                        if (int.tryParse(value) == null) return 'Please enter a valid number';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildGenderDropdown(
                                      initialValue: _gender,
                                      onSave: (value) => _gender = value!,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: SwitchListTile(
                                      title: const Text('Is Active'),
                                      value: _isActive,
                                      onChanged: (value) => setState(() => _isActive = value),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      activeColor: Colors.green,
                                      inactiveThumbColor: Colors.red,
                                      inactiveTrackColor: Colors.red[200],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _submit,
                                child: const Text('Save Changes'),
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

  Widget _buildTextField({
    required String label,
    required IconData icon,
    String? initialValue,
    required FormFieldSetter<String> onSave,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: onSave,
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget _buildGenderDropdown({
    required String initialValue,
    required FormFieldSetter<String> onSave,
  }) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) => onSave(value!),
      items: ['Male', 'Female', 'Other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create an updated Student object
      Student updatedStudent = Student(
        id: widget.student.id,
        name: '$_firstName ${_middleName.isNotEmpty ? _middleName + ' ' : ''}$_lastName',
        parentName: '$_fatherName & $_motherName',
        studentClass: _studentClass,
        division: _division,
        address: _address,
        place: _place,
        age: _age,
        gender: _gender,
        isActive: _isActive,
      );

      // Update the student using the controller
      Provider.of<StudentController>(context, listen: false).updateStudent(widget.student.id, updatedStudent);

      // Navigate back or show a success message
      Navigator.pop(context);
    }
  }
}
