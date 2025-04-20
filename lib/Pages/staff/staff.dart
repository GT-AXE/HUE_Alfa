import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hue/core/models/role.dart';
import 'package:hue/core/controllers/role_manager.dart';
import 'package:hue/core/utils/app_colors.dart';

class StaffPage extends StatefulWidget {
  final Role userRole;

  const StaffPage({Key? key, required this.userRole}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  String _selectedSection = "Administration";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  List<Map<String, String>> _staffList = [];
  final Map<String, List<Role>> _sections = {
    "Faculty Members": RoleManager.facultyRoles,
    "Student Services": RoleManager.studentRoles,
  };

  @override
  void dispose() {
    _searchController.dispose();
    _idController.dispose();
    _nameController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Staff Dashboard",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedSection,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          _buildSearchField(),
          const SizedBox(height: 10),
          Expanded(
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionStats(),
                    const SizedBox(height: 10),
                    Expanded(child: _buildDataTable()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search by ID or Name...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildSectionStats() {
    return Row(
      children: [
        _buildStatCard("Total users", _staffList.length.toString(), Icons.people_sharp),
        const SizedBox(width: 16),
        _buildStatCard("Active", _staffList.where((staff) => staff['status'] == 'Active').length.toString(), Icons.check_circle),
        const SizedBox(width: 16),
        _buildStatCard("On Leave", _staffList.where((staff) => staff['status'] == 'On Leave').length.toString(), Icons.beach_access),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(title, style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0))),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildDataTable() {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical, // Enable vertical scrolling
    child: Column(
      children: [
        // Add header row
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              _buildHeaderCell("ID"),
              _buildHeaderCell("Name"),
              _buildHeaderCell("Position"),
              _buildHeaderCell("Status"),
              _buildHeaderCell("Active"),
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.primary),
                onPressed: _showAddStaffDialog,
              ),
            ],
          ),
        ),
        // Add user data rows
        ..._staffList
            .where((staff) {
              final searchText = _searchController.text.toLowerCase();
              return staff['id']!.toLowerCase().contains(searchText) ||
                  staff['name']!.toLowerCase().contains(searchText);
            })
            .map((staff) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Row(
                  children: [
                    Expanded(child: Text(staff['id']!, style: const TextStyle(fontSize: 16))),
                    Expanded(child: Text(staff['name']!, style: const TextStyle(fontSize: 16))),
                    Expanded(child: Text(staff['position']!, style: const TextStyle(fontSize: 16))),
                    Expanded(child: _buildStatusChip(staff['status']!)),
                    IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.primary),
                      onPressed: () => _showEditDialog(staff),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteDialog(staff),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    ),
  );
}

// Helper widget to build each header cell
Widget _buildHeaderCell(String title) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildStatusChip(String status) {
  return Chip(
    label: Text(
      status,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: status == 'Active' ? Colors.green : Colors.orange,
  );
}


  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showAddStaffDialog,
      icon: const Icon(Icons.person_add),
      label: const Text("Add Student"),
      backgroundColor: AppColors.primary,
    );
  }

  void _showAddStaffDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add New user"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("ID (Numbers only)", _idController, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField("Full Name", _nameController),
                const SizedBox(height: 16),
                _buildTextField("Position", _positionController),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(onPressed: _addStaff, child: const Text("Add")),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _addStaff() {
    if (_idController.text.isNotEmpty && _nameController.text.length > 3) {
      setState(() {
        _staffList.add({
          'id': _idController.text,
          'name': _nameController.text,
          'position': _positionController.text,
          'status': 'Active',
        });
      });
      Navigator.pop(context);
    }
  }

  void _showEditDialog(Map<String, String> staff) {
    // Edit functionality implementation here
  }

  void _showDeleteDialog(Map<String, String> staff) {
    // Delete functionality implementation here
  }
}
