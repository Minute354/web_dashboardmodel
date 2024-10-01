// lib/controllers/class_controller.dart

import 'package:flutter/material.dart';
import '../models/class_model.dart';

class ClassController with ChangeNotifier {
  final List<ClassModel> _classes = [];

  List<ClassModel> get classes => _classes;

  void addClass(String className) {
    _classes.add(ClassModel(className: className));
    notifyListeners();
  }

  void removeClass(int index) {
    if (index >= 0 && index < _classes.length) {
      _classes.removeAt(index);
      notifyListeners();
    }
  }

  void updateClass(int index, String newClassName) {
    if (index >= 0 && index < _classes.length) {
      _classes[index] = ClassModel(className: newClassName);
      notifyListeners();
    }
  }
}
