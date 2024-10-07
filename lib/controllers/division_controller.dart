// lib/controllers/division_controller.dart

import 'package:flutter/material.dart';
import '../models/division_model.dart';

class DivisionController with ChangeNotifier {
  List<DivisionModel> _divisions = [];

  List<DivisionModel> get divisions => _divisions;

  void addDivision(String divisionName) {
    _divisions.add(DivisionModel(divisionName: divisionName));
    notifyListeners();
  }

  void updateDivision(int index, String newDivisionName) {
    _divisions[index] = DivisionModel(divisionName: newDivisionName);
    notifyListeners();
  }

  void removeDivision(int index) {
    _divisions.removeAt(index);
    notifyListeners();
  }
}
