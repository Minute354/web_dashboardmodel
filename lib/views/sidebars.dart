// lib/widgets/sidebar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/sidebar_controller.dart';
import '../models/sidebar_model.dart';
import '../data/sidebar_data.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sidebarController = Provider.of<SidebarController>(context);
    final selectedItem = sidebarController.selectedItem;

    return Container(
      width: 270,
      color: Colors.blueGrey.shade900,
      child: ListView(
        children: [
          // User Profile Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/student logo.png"),
                  radius: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white54),

          // Generate Sidebar Items
          ...sidebarItems.map((item) {
            if (item.subItems != null && item.subItems!.isNotEmpty) {
              return _buildExpansionSidebarItem(
                  context, item, selectedItem, sidebarController);
            } else {
              return _buildSidebarItem(
                icon: item.icon,
                label: item.label,
                onTap: () {
                  sidebarController.selectItem(item.label);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => item.page),
                  );
                },
                isSelected: selectedItem == item.label,
              );
            }
          }).toList(),
        ],
      ),
    );
  }

  // Widget for simple sidebar items
  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required Function onTap,
    required bool isSelected,
  }) {
    return Container(
      color: isSelected ? Colors.blueGrey.shade700 : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
        title: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
        ),
        onTap: () {
          Future.delayed(const Duration(milliseconds: 100), () {
            onTap();
          });
        },
      ),
    );
  }

  // Widget for expandable sidebar items
  Widget _buildExpansionSidebarItem(BuildContext context, SidebarItem item,
      String selectedItem, SidebarController controller) {
    bool isCurrentlyExpanded = controller.isExpanded(item.label);

    return ExpansionTile(
      leading: Icon(item.icon, color: Colors.white),
      title: Text(item.label, style: const TextStyle(color: Colors.white)),
      initiallyExpanded: isCurrentlyExpanded,
      onExpansionChanged: (bool expanded) {
        controller.setExpanded(item.label, expanded);
      },
      iconColor: Colors.white, // Ensure arrow is white when collapsed
      collapsedIconColor: Colors.grey, // Ensure arrow is white when expanded
      children: item.subItems!.map((subItem) {
        return _buildSidebarItem(
          icon: subItem.icon,
          label: subItem.label,
          onTap: () {
            controller.selectItem(subItem.label);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => subItem.page),
            );
          },
          isSelected: selectedItem == subItem.label,
        );
      }).toList(),
    );
  }
}
