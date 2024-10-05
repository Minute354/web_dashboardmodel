// lib/controllers/class_controller.dart

import 'package:flutter/material.dart';
import 'package:school_web_app/models/class_model.dart';

class ClassController with ChangeNotifier {
  List<ClassModel> _classes = [];

  List<ClassModel> get classes => _classes;

  // Method to add a new class
  void addClass(String className, String division) {
    // Determine the next ID
    int nextId = _classes.isNotEmpty
        ? _classes.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;

    // Create a new ClassModel
    ClassModel newClass = ClassModel(
      id: nextId,
      className: className,
      division: division,
    );

    _classes.add(newClass);
    notifyListeners();
  }

  // Method to update an existing class
  void updateClass(int index, String className, String division) {
    ClassModel updatedClass = ClassModel(
      id: _classes[index].id, // Preserve the original ID
      className: className,
      division: division,
    );

    _classes[index] = updatedClass;
    notifyListeners();
  }

  // Method to remove a class
  void removeClass(int index) {
    _classes.removeAt(index);
    notifyListeners();
  }
}
