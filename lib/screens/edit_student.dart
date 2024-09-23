import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  EditStudentPage({required this.student});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  String gender = 'Male';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    divisionController.text = widget.student.division;
    classController.text = widget.student.studentClass;
    parentNameController.text = widget.student.parentName;
    ageController.text = widget.student.age.toString();
    placeController.text = widget.student.place;
    gender = widget.student.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: divisionController,
              decoration: InputDecoration(labelText: 'Division'),
            ),
            TextField(
              controller: classController,
              decoration: InputDecoration(labelText: 'Class'),
            ),
            TextField(
              controller: parentNameController,
              decoration: InputDecoration(labelText: 'Parent Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: placeController,
              decoration: InputDecoration(labelText: 'Place'),
            ),
            Row(
              children: [
                Text('Gender: '),
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final studentController =
                    Provider.of<StudentController>(context, listen: false);
                studentController.editStudent(
                  widget.student.id,
                  nameController.text,
                  divisionController.text,
                  classController.text,
                  parentNameController.text,
                  int.parse(ageController.text),
                  gender,
                  placeController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
