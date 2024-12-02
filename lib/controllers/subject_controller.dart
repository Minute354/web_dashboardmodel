// lib/controllers/subject_controller.dart

import 'package:flutter/material.dart';
import '../models/subject_model.dart';

class SubjectController extends ChangeNotifier {
  // List to hold subjects
  List<SubjectModel> _subjects = [];

  List<SubjectModel> get subjects => _subjects;

  // Method to add a new subject
  void addSubject(String subjectName) {
    _subjects.add(SubjectModel(subjectName: subjectName));
  
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to update an existing subject
  void updateSubject(int index, String newSubjectName) {
    _subjects[index].subjectName = newSubjectName;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to delete a subject
  void deleteSubject(int index) {
    _subjects.removeAt(index);
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
