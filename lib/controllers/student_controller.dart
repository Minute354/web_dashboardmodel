import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentController with ChangeNotifier {
  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  bool _searchActive = false; // Track if a search is active

  // Return the filtered students or all students if no filter is applied
  List<Student> get students => _searchActive ? _filteredStudents : _students;

  // Add a new student to the list
  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  // Update an existing student's details
  void updateStudent(int id, Student updatedStudent) {
    final index = _students.indexWhere((student) => student.id == id);
    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  // Delete a student from the list
  void deleteStudent(int id) {
    _students.removeWhere((student) => student.id == id);
    // If a search is active, also remove the student from the filtered list
    if (_searchActive) {
      _filteredStudents.removeWhere((student) => student.id == id);
    }
    notifyListeners();
  }

  // Activate a student
  void activateStudent(int id) {
    final student = _students.firstWhere((student) => student.id == id, orElse: () => throw Exception('Student not found'));
    student.isActive = true;
    notifyListeners();
  }

  // Deactivate a student
  void deactivateStudent(int id) {
    final student = _students.firstWhere((student) => student.id == id, orElse: () => throw Exception('Student not found'));
    student.isActive = false;
    notifyListeners();
  }

  // Set the student list
  void setStudents(List<Student> students) {
    _students = students;
    _filteredStudents = List.from(_students); // Copy of the students list
    notifyListeners();
  }

  // Filter students based on the search query
  void filterStudents(String query) {
    if (query.isEmpty) {
      _filteredStudents = List.from(_students); // If query is empty, show all students
      _searchActive = false;
    } else {
      _filteredStudents = _students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _searchActive = true;
    }
    notifyListeners();
  }

  // Sort students by name
  void sortStudentsByName() {
    _students.sort((a, b) => a.name.compareTo(b.name));
    if (_searchActive) {
      _filteredStudents.sort((a, b) => a.name.compareTo(b.name));
    }
    notifyListeners();
  }
}
