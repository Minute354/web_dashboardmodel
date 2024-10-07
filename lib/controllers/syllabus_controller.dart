// controllers/syllabus_controller.dart

import 'package:flutter/material.dart';
import '../models/syllabus_model.dart';

class SyllabusController with ChangeNotifier {
  List<Syllabus> _syllabi = [];

  List<Syllabus> get syllabi => _syllabi;

  void addSyllabus(Syllabus syllabus) {
    _syllabi.add(syllabus);
    notifyListeners();
  }

  void updateSyllabus(int index, Syllabus updatedSyllabus) {
    if (index >= 0 && index < _syllabi.length) {
      _syllabi[index] = updatedSyllabus;
      notifyListeners();
    }
  }

  void deleteSyllabus(int index) {
    if (index >= 0 && index < _syllabi.length) {
      _syllabi.removeAt(index);
      notifyListeners();
    }
  }
}
