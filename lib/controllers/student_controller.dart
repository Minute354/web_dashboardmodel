import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentController with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  void addStudent(String name, String division, String studentClass, String parentName, int age, String gender, String place) {
    final newStudent = Student(
      id: DateTime.now().toString(),
      name: name,
      division: division,
      studentClass: studentClass,
      parentName: parentName,
      age: age,
      gender: gender,
      place: place,
      isActive: true,
    );
    _students.add(newStudent);
    notifyListeners();
  }

  void editStudent(String id, String name, String division, String studentClass, String parentName, int age, String gender, String place) {
    final studentIndex = _students.indexWhere((student) => student.id == id);
    if (studentIndex >= 0) {
      _students[studentIndex] = Student(
        id: id,
        name: name,
        division: division,
        studentClass: studentClass,
        parentName: parentName,
        age: age,
        gender: gender,
        place: place,
        isActive: _students[studentIndex].isActive,
      );
      notifyListeners();
    }
  }

  void activateStudent(String id) {
    final student = _students.firstWhere((student) => student.id == id);
    student.isActive = true;
    notifyListeners();
  }

  void deactivateStudent(String id) {
    final student = _students.firstWhere((student) => student.id == id);
    student.isActive = false;
    notifyListeners();
  }

  void deleteStudent(String id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  Student? viewStudent(String id) {
  try {
    return _students.firstWhere((student) => student.id == id);
  } catch (e) {
    return null; // Return null if no student is found
  }
}

}
