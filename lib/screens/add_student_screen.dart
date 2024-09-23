import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/student_controller.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
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
                studentController.addStudent(
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
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
