// controllers/student_controller.dart
import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentController with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void updateStudent(int id, Student updatedStudent) {
    final index = _students.indexWhere((student) => student.id == id);
    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  void deleteStudent(int id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  void activateStudent(int id) {
    final student = _students.firstWhere((student) => student.id == id);
    student.isActive = true;
    notifyListeners();
  }

  void deactivateStudent(int id) {
    final student = _students.firstWhere((student) => student.id == id);
    student.isActive = false;
    notifyListeners();
  }
}
