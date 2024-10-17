// lib/controllers/class_controller.dart

import 'package:flutter/material.dart';
import '../models/class_model.dart';

class ClassController with ChangeNotifier {
  List<ClassModel> _classes = [];
  int _nextId = 1; // To assign unique IDs

  List<ClassModel> get classes => _classes;

  void addClass(String className) {
    _classes.add(ClassModel(id: _nextId++, className: className));
    notifyListeners();
  }

  void updateClass(int index, String newClassName) {
    _classes[index] = ClassModel(id: _classes[index].id, className: newClassName);
    notifyListeners();
  }

  void removeClass(int index) {
    _classes.removeAt(index);
    notifyListeners();
  }
}
