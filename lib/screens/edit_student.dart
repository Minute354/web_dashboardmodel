// views/edit_student_screen.dart
import 'package:flutter/material.dart';
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
  late String _name;
  late String _studentClass;
  late String _parentName;
  late String _division;
  late String _place;
  late int _age;
  late String _gender;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _name = widget.student.name;
    _studentClass = widget.student.studentClass;
    _parentName = widget.student.parentName;
    _division = widget.student.division;
    _place = widget.student.place;
    _age = widget.student.age;
    _gender = widget.student.gender;
    _isActive = widget.student.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Student Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _studentClass,
                decoration: InputDecoration(labelText: 'Class'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter class';
                  }
                  return null;
                },
                onSaved: (value) {
                  _studentClass = value!;
                },
              ),
              TextFormField(
                initialValue: _parentName,
                decoration: InputDecoration(labelText: 'Parent Name'),
                onSaved: (value) {
                  _parentName = value!;
                },
              ),
              TextFormField(
                initialValue: _division,
                decoration: InputDecoration(labelText: 'Division'),
                onSaved: (value) {
                  _division = value!;
                },
              ),
              TextFormField(
                initialValue: _place,
                decoration: InputDecoration(labelText: 'Place'),
                onSaved: (value) {
                  _place = value!;
                },
              ),
              TextFormField(
                initialValue: _age.toString(),
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onSaved: (value) {
                  _gender = value!;
                },
              ),
              SwitchListTile(
                title: Text('Is Active'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<StudentController>(context, listen: false).updateStudent(
                      widget.student.id,
                      Student(
                        id: widget.student.id,
                        name: _name,
                        studentClass: _studentClass,
                        parentName: _parentName,
                        division: _division,
                        place: _place,
                        age: _age,
                        gender: _gender,
                        isActive: _isActive,
                      ),
                    );
                    Navigator.of(context).pop(); // Go back after editing
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
