// lib/controllers/sidebar_controller.dart
import 'package:flutter/material.dart';

class SidebarController with ChangeNotifier {
  String _selectedItem = 'Dashboard'; // Default selected item

  String get selectedItem => _selectedItem;

  void selectItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  // Map to keep track of expanded state of expansion tiles
  final Map<String, bool> _expandedTiles = {};

  bool isExpanded(String item) => _expandedTiles[item] ?? false;

  void setExpanded(String item, bool isExpanded) {
    _expandedTiles[item] = isExpanded;
    notifyListeners();
  }
}
