import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/student_controller.dart';
import '../models/student_model.dart';
import 'add_student_screen.dart';
import 'edit_student.dart';

class StudentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Student Management',style: GoogleFonts.poppins(color: Colors.white),),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddStudentPage()),
              );
            },
            icon: Icon(Icons.add),
            label: Text('Add Student',style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
      body: Consumer<StudentController>(
        builder: (context, studentController, child) {
          return ListView.builder(
            itemCount: studentController.students.length,
            itemBuilder: (context, index) {
              final student = studentController.students[index];
              return Card(
                color: Colors.grey,
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'), // Display the index
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${student.name}'),
                      SizedBox(width: 100,),
                      Text('Class: ${student.studentClass}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(student.isActive ? 'Active' : 'Inactive'),
                    backgroundColor: student.isActive ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    _showStudentDetails(context, student, studentController);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showStudentDetails(BuildContext context, Student student,
      StudentController studentController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Name: ${student.name}'),
              Text('Division: ${student.division}'),
              Text('Class: ${student.studentClass}'),
              Text('Parent Name: ${student.parentName}'),
              Text('Age: ${student.age}'),
              Text('Gender: ${student.gender}'),
              Text('Place: ${student.place}'),
              Text('Status: ${student.isActive ? 'Active' : 'Inactive'}'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditStudentPage(student: student),
                      ),
                    );
                  },
                  child: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (student.isActive) {
                      studentController.deactivateStudent(student.id);
                    } else {
                      studentController.activateStudent(student.id);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(student.isActive ? 'Deactivate' : 'Activate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: student.isActive ? Colors.blue : Colors.teal,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    studentController.deleteStudent(student.id);
                    Navigator.of(context).pop(); // Close dialog after delete
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
