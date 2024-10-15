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

                  // "Modules" section label
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            for (String module in modules)
                              Column(
                                children: [
                                  // Module section with label inside border
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12), // Adjust margin for label
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blueGrey),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            // First column: Module name
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                module,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),

                                            // Second column: Actions dropdown
                                            Expanded(
                                              flex: 2,
                                              child: MultiSelectDropdown(
                                                moduleName: module,
                                                actions: actions,
                                                selectedActions: selectedActions[module]!,
                                                onActionChanged: (selected) {
                                                  setState(() {
                                                    selectedActions[module] = selected;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 10, // Adjust the label position
                                        top: 0,  // Align with the top of the container
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          color: Colors.white, // Background color to overlay nicely
                                          child: Text(
                                            "Module",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.white,
                          child: Text(
                            'Lookups',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actions'),
            if (isDropdownOpen)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    for (String action in widget.actions)
                      CheckboxListTile(
                        title: Text(action),
                        value: widget.selectedActions.contains(action),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              widget.onActionChanged([...widget.selectedActions, action]);
                            } else {
                              widget.onActionChanged(widget.selectedActions.where((a) => a != action).toList());
                            }
                          });
                        },
                      ),
                    // OK button to confirm selection and close dropdown
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isDropdownOpen = false; // Close dropdown
                          });
                        },
                        child: Text('OK'),
                      ),
                    ),
                  ],
                ),
              ),
            if (isDropdownOpen)
              Icon(Icons.arrow_drop_up)
            else
              Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
