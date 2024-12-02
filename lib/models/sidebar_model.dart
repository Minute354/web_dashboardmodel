// lib/models/sidebar_item.dart
import 'package:flutter/material.dart';

class SidebarItem {
  final IconData icon;
  final String label;
  final Widget page;
  final List<SidebarItem>? subItems;

  SidebarItem({
    required this.icon,
    required this.label,
    required this.page,
    this.subItems,
  });
}
