import 'package:flutter/material.dart';
import 'package:school_web_app/models/role_models.dart';

class RoleController extends ChangeNotifier {
  List<RoleModel> _roles = [];

  List<RoleModel> get roles => _roles;

  // Function to add a new role
  void addRole(RoleModel role) {
    _roles.add(role);
    notifyListeners(); // Notify UI of changes
  }

  // Function to update an existing role
  void updateRole(int index, RoleModel updatedRole) {
    if (index >= 0 && index < _roles.length) {
      _roles[index] = updatedRole;
      notifyListeners();
    }
  }

  // Function to delete a role
  void deleteRole(int index) {
    if (index >= 0 && index < _roles.length) {
      _roles.removeAt(index);
      notifyListeners();
    }
  }

  // Function to toggle the active/inactive status of a role
  void toggleRoleStatus(int index) {
    if (index >= 0 && index < _roles.length) {
      _roles[index].status =
          _roles[index].status == 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';
      notifyListeners();
    }
  }

  // Function to fetch roles from an API or database (mocked here)
  void fetchRoles() {
    _roles = [
      RoleModel(status: 'ACTIVE', code: 'ROL1000001', role: 'Admin', createdAt: '2024-09-11'),
      RoleModel(status: 'ACTIVE', code: 'ROL1000002', role: 'Management', createdAt: '2024-10-02'),
      RoleModel(status: 'INACTIVE', code: 'ROL1000008', role: 'Office Head', createdAt: '2024-10-02'),
      RoleModel(status: 'ACTIVE', code: 'ROL1000011', role: 'Teacher', createdAt: '2024-10-02'),
      RoleModel(status: 'ACTIVE', code: 'ROL1000010', role: 'Parent', createdAt: '2024-10-02'),
      RoleModel(status: 'ACTIVE', code: 'ROL1000009', role: 'User', createdAt: '2024-10-02'),
    ];
    notifyListeners();
  }
}
