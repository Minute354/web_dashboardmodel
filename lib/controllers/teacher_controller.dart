// lib/controllers/teacher_controller.dart

import 'package:flutter/material.dart';
import '../models/teacher_model.dart';

class TeacherController with ChangeNotifier {
  List<Teacher> _teachers = []; // Original list of teachers
  List<Teacher> _filteredTeachers = []; // List after applying filters

  TeacherController() {
    _filteredTeachers = _teachers; // Initialize filtered list
  }

  // Getter to retrieve the original list of teachers
  List<Teacher> get teachers => _teachers;

  // Getter to retrieve the filtered list of teachers
  List<Teacher> get filteredTeachers => _filteredTeachers;

  // Method to add a new teacher
  void addTeacher(Teacher teacher) {
    _teachers.add(teacher);
    _filteredTeachers = _teachers; // Reset the filtered list
    notifyListeners(); // Notify listeners about the state change
  }

  // Method to delete a teacher by ID
  void deleteTeacher(int id) {
    _teachers.removeWhere((teacher) => teacher.id == id);
    _filteredTeachers = _teachers; // Reset the filtered list
    notifyListeners(); // Notify listeners about the state change
  }

  // Method to update an existing teacher
  void updateTeacher(int id, Teacher updatedTeacher) {
    final index = _teachers.indexWhere((teacher) => teacher.id == id);
    if (index != -1) {
      _teachers[index] = updatedTeacher;
      _filteredTeachers = _teachers; // Reset the filtered list
      notifyListeners(); // Notify listeners about the state change
    }
  }

  // Method to update teacher's active status
  void updateTeacherStatus(int id, bool isActive) {
    final index = _teachers.indexWhere((teacher) => teacher.id == id);
    if (index != -1) {
      _teachers[index].isActive = isActive; // Update the isActive property
      notifyListeners(); // Notify listeners about the state change
    }
  }

  // Method to filter teachers based on search query
  void filterTeachers(String query) {
    if (query.isEmpty) {
      _filteredTeachers = _teachers;
    } else {
      _filteredTeachers = _teachers.where((teacher) {
        final fullName = '${teacher.firstName} ${teacher.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Notify listeners about the state change
  }
}
