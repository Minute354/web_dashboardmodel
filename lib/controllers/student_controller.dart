import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentController with ChangeNotifier {
  List<Student> _students = [];
  List<Student> _filteredStudents = []; // New list for filtered students

  List<Student> get students => _students;
  List<Student> get filteredStudents => _filteredStudents.isNotEmpty ? _filteredStudents : _students; // Show filtered list or all students

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

  // Method to filter students based on search query
  void filterStudents(String query) {
    if (query.isEmpty) {
      _filteredStudents = _students; // Reset to show all students
    } else {
      _filteredStudents = _students.where((student) {
        // Check if first name, last name, or any other property contains the search query
        final fullName = '${student.firstName} ${student.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Notify listeners about the state change
    }
}