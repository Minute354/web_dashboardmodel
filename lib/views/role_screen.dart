import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_web_app/views/sidebars.dart';

class RoleScreen extends StatefulWidget {
  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool isAddingRole = false;
  final TextEditingController roleController = TextEditingController();
  bool isActive = true;
  String? selectedModuleType;
  int? editIndex;

  List<Map<String, dynamic>> roles = [
    {
      'status': 'ACTIVE',
      'code': 'ROL1000001',
      'role': 'Admin',
      'createdAt': '2024-09-11'
    },
    {
      'status': 'ACTIVE',
      'code': 'ROL1000002',
      'role': 'Management',
      'createdAt': '2024-10-02'
    },
    {
      'status': 'INACTIVE',
      'code': 'ROL1000008',
      'role': 'Office Head',
      'createdAt': '2024-10-02'
    },
    {
      'status': 'ACTIVE',
      'code': 'ROL1000011',
      'role': 'Teacher',
      'createdAt': '2024-10-02'
    },
    {
      'status': 'ACTIVE',
      'code': 'ROL1000010',
      'role': 'Parent',
      'createdAt': '2024-10-02'
    },
    {
      'status': 'ACTIVE',
      'code': 'ROL1000009',
      'role': 'User',
      'createdAt': '2024-10-02'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        
      ),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          'Role Allocation',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Add New Role Button
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        editIndex = null; // Ensure no role is being edited
                        roleController.clear();
                        selectedModuleType = null;
                        isActive = true; // Default to active when adding
                      });
                      _showAddRoleDialog();
                    },
                    icon: Icon(Icons.add),
                    label: Text('New Role'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Role Table View
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 1200,
                          child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.all(Colors.blueGrey.shade900),
                            columns: [
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Code',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Role',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Created At',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            rows: roles.map((role) {
                              return DataRow(cells: [
                                DataCell(SizedBox(
                                  width: 80,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: role['status'] == 'ACTIVE'
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          // Toggle status
                                          role['status'] =
                                              role['status'] == 'ACTIVE'
                                                  ? 'INACTIVE'
                                                  : 'ACTIVE';
                                        });
                                      },
                                      child: Text(
                                        role['status'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        setState(() {
                                          editIndex = roles.indexOf(role);
                                          roleController.text = role['role'];
                                          selectedModuleType = null; // Update based on your logic
                                          isActive = role['status'] == 'ACTIVE';
                                        });
                                        _showAddRoleDialog();
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _showDeleteConfirmation(role);
                                      },
                                    ),
                                  ],
                                )),
                                DataCell(Text(role['code'])),
                                DataCell(Text(role['role'])),
                                DataCell(Text(role['createdAt'])),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the "Add/Edit Role" dialog
  void _showAddRoleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(editIndex == null ? 'Add Role' : 'Edit Role'),
          content: SizedBox(
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(
                    labelText: 'Role Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedModuleType,
                  decoration: InputDecoration(
                    labelText: 'Module Types',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    'Admin Module',
                    'User Module',
                    'Teachers Module',
                    'Parents Module'
                  ].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedModuleType = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Active"),
                    Switch(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (editIndex == null) {
                  _addRole();
                } else {
                  _updateRole();
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  // Function to add the new role
  void _addRole() {
    setState(() {
      roles.add({
        'status': isActive ? 'ACTIVE' : 'INACTIVE',
        'code': 'ROL' + (roles.length + 1000001).toString(),
        'role': roleController.text,
        'createdAt': DateTime.now().toString().split(' ')[0]
      });
    });
  }

  // Function to update an existing role
  void _updateRole() {
    if (editIndex != null) {
      setState(() {
        roles[editIndex!] = {
          'status': isActive ? 'ACTIVE' : 'INACTIVE',
          'code': roles[editIndex!]['code'],
          'role': roleController.text,
          'createdAt': roles[editIndex!]['createdAt'],
        };
      });
    }
  }

  // Function to show delete confirmation dialog
  void _showDeleteConfirmation(Map<String, dynamic> role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Role'),
          content: Text('Are you sure you want to delete this role?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  roles.remove(role); // Remove the role
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
