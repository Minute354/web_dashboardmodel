import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../views/sidebars.dart';

class UserListPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        automaticallyImplyLeading: isSmallScreen,
      ),
      drawer: isSmallScreen ? Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Users',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Add User Button
                  ElevatedButton.icon(
                    onPressed: () => _showAddEditUserDialog(context, null),
                    icon: Icon(Icons.add),
                    label: Text(
                      'Add User',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search by name',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.indigo, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) {
                              Provider.of<UserController>(context,
                                      listen: false)
                                  .filterUsers(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<UserController>(
                      builder: (context, userController, child) {
                        List<User> users = userController
                            .users; // Ensure this list is populated by fetching data from your API.

                        // Display loading state when no users are available
                        if (users.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // DataTable for displaying users
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: DataTable(
                                  columnSpacing: 20.0,
                                  headingRowColor: MaterialStateProperty.all(
                                      Colors.blueGrey.shade900),
                                  border: TableBorder.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text('S/N',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Actions',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Name',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Email',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Phone',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Address',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    DataColumn(
                                      label: Text('Payment GST',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                    users.length,
                                    (index) {
                                      final user = users[index];
                                      return DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text((index + 1)
                                              .toString())), // Serial number
                                          DataCell(
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit,
                                                      color: Colors.blueAccent),
                                                  onPressed: () {
                                                    _showAddEditUserDialog(
                                                        context, user);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    _showDeleteConfirmationDialog(
                                                        context, user);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          DataCell(Text(user.name)),
                                          DataCell(Text(user.email)),
                                          DataCell(Text(user.phone)),
                                          DataCell(
                                            Text(
                                                '${user.address.street}, ${user.address.city}, ${user.address.state}'),
                                          ),
                                          DataCell(Text(
                                              user.paymentAddress.gstNumber)),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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

  // Show Add/Edit User Dialog
  void _showAddEditUserDialog(BuildContext context, User? user) {
    final userController = Provider.of<UserController>(context, listen: false);
    // Open dialog to add/edit user using userController.addUser/editUser
  }

  // Show Delete Confirmation Dialog
  void _showDeleteConfirmationDialog(BuildContext context, User user) {
    final userController = Provider.of<UserController>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                userController.deleteUser(user.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
