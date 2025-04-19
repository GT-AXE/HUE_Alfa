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
    "Administration": RoleManager.adminRoles,
    "Faculty Members": RoleManager.facultyRoles,
    "Student Services": RoleManager.studentRoles,
    "Management": RoleManager.staffRoles,
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
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Staff Management",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Admin User'),
            accountEmail: const Text('dev_axe@horus.edu.eg'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search staff by ID or Name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: _sections.keys
                  .where((section) => section
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .map((section) => ListTile(
                        title: Text(section),
                        onTap: () {
                          setState(() {
                            _selectedSection = section;
                          });
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedSection,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          _buildSearchField(),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionStats(),
                    const SizedBox(height: 20),
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
        _buildStatCard("Total user", _staffList.length.toString(), Icons.people),
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
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: AppColors.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      child: DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Position")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Actions")),
        ],
        rows: _staffList
            .where((staff) {
              final searchText = _searchController.text.toLowerCase();
              return staff['id']!.toLowerCase().contains(searchText) ||
                  staff['name']!.toLowerCase().contains(searchText);
            })
            .map((staff) {
          return DataRow(
            cells: [
              DataCell(Text(staff['id']!)),
              DataCell(Text(staff['name']!)),
              DataCell(Text(staff['position']!)),
              DataCell(
                Chip(
                  label: Text(
                    staff['status']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: staff['status'] == 'Active' ? Colors.green : Colors.orange,
                ),
              ),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.primary,
                      onPressed: () => _showEditDialog(staff), 
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => _showDeleteDialog(staff),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showAddStaffDialog,
      icon: const Icon(Icons.person_add),
      label: const Text("Add user"),
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
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: "ID", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _positionController,
                  decoration: const InputDecoration(labelText: "Position", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(onPressed: _addStaff, child: const Text("Add user")),
          ],
        );
      },
    );
  }

  void _addStaff() {
    if (_idController.text.isEmpty || _nameController.text.isEmpty || _positionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill in all fields.")));
      return;
    }

    if (_staffList.any((staff) => staff['id'] == _idController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ID already exists.")));
      return;
    }

    setState(() {
      _staffList.add({
        'id': _idController.text,
        'name': _nameController.text,
        'position': _positionController.text,
        'status': 'Active',
      });
      _idController.clear();
      _nameController.clear();
      _positionController.clear();
    });
    Navigator.pop(context);
  }

  void _showEditDialog(Map<String, String> staff) {
    _nameController.text = staff['name']!;
    _positionController.text = staff['position']!;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit user"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _positionController,
                  decoration: const InputDecoration(labelText: "Position", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(onPressed: () => _editStaff(staff), child: const Text("Save Changes")),
          ],
        );
      },
    );
  }

  void _editStaff(Map<String, String> staff) {
    setState(() {
      staff['name'] = _nameController.text;
      staff['position'] = _positionController.text;
    });
    Navigator.pop(context);
  }

  void _showDeleteDialog(Map<String, String> staff) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete user"),
          content: const Text("Are you sure you want to delete this user member?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(onPressed: () => _deleteStaff(staff), child: const Text("Delete")),
          ],
        );
      },
    );
  }

  void _deleteStaff(Map<String, String> staff) {
    setState(() {
      _staffList.remove(staff);
    });
    Navigator.pop(context);
  }
}
