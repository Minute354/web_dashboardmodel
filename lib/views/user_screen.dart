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
                        List<User> users = userController.users;

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
                                              user.GSTNumber)),
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
    // Create controllers for input fields
    final nameController = TextEditingController(text: user?.name);
    final emailController = TextEditingController(text: user?.email);
    final phoneController = TextEditingController(text: user?.phone);
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final gstNumberController = TextEditingController(text: user?.GSTNumber);

    // Address controllers
    final streetController = TextEditingController(text: user?.address.street);
    final cityController = TextEditingController(text: user?.address.city);
    final stateController = TextEditingController(text: user?.address.state);
    final districtController =
        TextEditingController(text: user?.address.district);
    final zipCodeController =
        TextEditingController(text: user?.address.zipCode);

    // Payment Address controllers

    final paymentCityController =
        TextEditingController(text: user?.paymentAddress.city);
    final paymentStateController =
        TextEditingController(text: user?.paymentAddress.state);
    final paymentDistrictController =
        TextEditingController(text: user?.paymentAddress.district);
    final paymentZipCodeController =
        TextEditingController(text: user?.paymentAddress.zipCode);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user == null ? 'Add User' : 'Edit User'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),
                // Password Fields
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                // Address Fields
                Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  controller: streetController,
                  decoration: InputDecoration(labelText: 'Street'),
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextField(
                  controller: districtController,
                  decoration: InputDecoration(labelText: 'District'),
                ),
                TextField(
                  controller: zipCodeController,
                  decoration: InputDecoration(labelText: 'Zip Code'),
                ),
                // Payment Address Fields
                Text('Payment Address',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  controller: gstNumberController,
                  decoration: InputDecoration(labelText: 'GST Number'),
                ),
                TextField(
                  controller: paymentCityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: paymentStateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextField(
                  controller: paymentDistrictController,
                  decoration: InputDecoration(labelText: 'District'),
                ),
                TextField(
                  controller: paymentZipCodeController,
                  decoration: InputDecoration(labelText: 'Zip Code'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Validate Passwords
                if (passwordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match!')),
                  );
                  return; // Return early if passwords don't match
                }

                // Create User object
                final newUser = User(
                  id: user?.id ??
                      DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  GSTNumber: gstNumberController.text,

                  address: Address(
                    street: streetController.text,
                    city: cityController.text,
                    state: stateController.text,
                    district: districtController.text,
                    zipCode: zipCodeController.text,
                  ),
                  paymentAddress: PaymentAddress(
                    city: paymentCityController.text,
                    state: paymentStateController.text,
                    district: paymentDistrictController.text,
                    zipCode: paymentZipCodeController.text,
                  ),
                  password: passwordController.text,
                  role: '',
                  status: true,
                  isDeleted: false,
                  confirmPassword:
                      passwordController.text, // Include password here
                );

                if (user == null) {
                  // Add User
                  await userController.addUser(newUser);
                } else {
                  // Edit User
                  await userController.editUser(newUser);
                }

                // Close the dialog and refresh the user list
                Navigator.of(context).pop();
              },
              child: Text(user == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Confirmation Dialog
  void _showDeleteConfirmationDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Delete user
                await Provider.of<UserController>(context, listen: false)
                    .deleteUser(user as String);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
