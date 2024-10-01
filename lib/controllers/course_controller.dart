// lib/controllers/course_controller.dart

import 'package:flutter/material.dart';
import 'package:school_web_app/models/course_model.dart';

class CourseController with ChangeNotifier {
  List<CourseModel> _courses = [];

  List<CourseModel> get courses => _courses;

  // Method to add a new course
  void addCourse(String courseName) {
    _courses.add(CourseModel(courseName: courseName));
    notifyListeners(); // Notify listeners about the change
  }

  // Method to update an existing course
  void updateCourse(int index, String courseName) {
    if (index >= 0 && index < _courses.length) {
      _courses[index].courseName = courseName;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to delete a course
  void deleteCourse(int index) {
    if (index >= 0 && index < _courses.length) {
      _courses.removeAt(index);
      notifyListeners(); // Notify listeners about the change
    }
  }
}
