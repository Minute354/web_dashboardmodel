import 'package:flutter/material.dart';
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
        title: Text('Student Management'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddStudentPage()),
              );
            },
            icon: Icon(Icons.add),
            label: Text('Add Student'),
          ),
        ],
      ),
      body: Consumer<StudentController>(
        builder: (context, studentController, child) {
          return DataTable(
            columns: [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Class')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: studentController.students.map((student) {
              return DataRow(cells: [
                DataCell(Text(student.id)),
                DataCell(Text(student.name)),
                DataCell(Text(student.studentClass)),
                DataCell(Chip(
                  label: Text(student.isActive ? 'Active' : 'Inactive'),
                  backgroundColor:
                      student.isActive ? Colors.green : Colors.red,
                )),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showStudentDetails(context, student);
                      },
                      child: Text('View'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditStudentPage(
                              student: student,
                            ),
                          ),
                        );
                      },
                      child: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (student.isActive) {
                          studentController.deactivateStudent(student.id);
                        } else {
                          studentController.activateStudent(student.id);
                        }
                      },
                      child: Text(
                        student.isActive ? 'Deactivate' : 'Activate',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            student.isActive ? Colors.blue : Colors.teal,
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        studentController.deleteStudent(student.id);
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }

  void _showStudentDetails(BuildContext context, Student student) {
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
