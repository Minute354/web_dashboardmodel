import 'package:flutter/material.dart';
import 'package:school_web_app/views/sidebars.dart';

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  // Dummy roles data
  final List<String> roles = ['Admin', 'Teacher', 'HR Manager'];
  String? selectedRole;

  // Modules list
  final List<String> modules = ['Class', 'Division', 'Course', 'Subject'];

  // Actions list
  final List<String> actions = ['Add', 'List', 'Edit', 'Delete'];
  Map<String, List<String>> selectedActions = {
    'Class': [],
    'Division': [],
    'Course': [],
    'Subject': [],
  };

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
           if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
              child: ListView(
                children: [
                  // Dropdown for Role selection
                  Text(
                    'Roles',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Select Role'),
                    value: selectedRole,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRole = newValue;
                      });
                    },
                    items: roles.map((role) {
                      return DropdownMenuItem(
                        child: Text(role),
                        value: role,
                      );
                    }).toList(),
                    underline: Container(height: 2, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 20),

                  // Modules section (Class, Division, Course, Subject)
                  for (String module in modules)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Module: $module',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),

                        // Multi-select dropdown for actions
                        MultiSelectDropdown(
                          moduleName: module,
                          actions: actions,
                          selectedActions: selectedActions[module]!,
                          onActionChanged: (selected) {
                            setState(() {
                              selectedActions[module] = selected;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for multi-select dropdown with checkboxes
class MultiSelectDropdown extends StatefulWidget {
  final String moduleName;
  final List<String> actions;
  final List<String> selectedActions;
  final Function(List<String>) onActionChanged;

  MultiSelectDropdown({
    required this.moduleName,
    required this.actions,
    required this.selectedActions,
    required this.onActionChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  bool isDropdownOpen = false;
  List<String> tempSelectedActions = [];

  @override
  void initState() {
    super.initState();
    tempSelectedActions = List.from(widget.selectedActions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Actions'),
                Icon(isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Column(
            children: [
              Column(
                children: widget.actions.map((action) {
                  return CheckboxListTile(
                    title: Text(action),
                    value: tempSelectedActions.contains(action),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedActions.add(action);
                        } else {
                          tempSelectedActions.remove(action);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              // OK button to confirm selection and close dropdown
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onActionChanged(tempSelectedActions);
                      isDropdownOpen = false; // Close dropdown
                    });
                  },
                  child: Text('OK'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
