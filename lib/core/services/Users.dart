import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final supabase = Supabase.instance.client;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final departmentController = TextEditingController();

  String selectedRole = 'user';
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final data = await supabase.from('users').select();
      setState(() => users = data);
    } catch (e) {
      print('Fetch error: $e');
    }
  }

  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim()) ?? 0;
    final department = departmentController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty || department.isEmpty) return;

    try {
      final authRes = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final userId = authRes.user?.id;
      if (userId != null) {
        await supabase.from('users').insert({
          'id': userId,
          'name': name,
          'email': email,
          'age': age,
          'role': selectedRole,
          'department': department,
        });

        fetchUsers();
        clearFields();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully')),
        );
      }
    } catch (e) {
      print('Registration error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await supabase.from('users').delete().eq('id', id);
      fetchUsers();
    } catch (e) {
      print('Delete error: $e');
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    ageController.clear();
    departmentController.clear();
    selectedRole = 'user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Manager')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Username')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
              TextField(controller: ageController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Age')),
              TextField(controller: departmentController, decoration: const InputDecoration(labelText: 'Department')),

              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedRole,
                onChanged: (val) => setState(() => selectedRole = val!),
                items: ['user', 'admin', 'moderator'].map((r) {
                  return DropdownMenuItem(value: r, child: Text(r.toUpperCase()));
                }).toList(),
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text('Register User'),
              ),

              const Divider(height: 30),
              const Text('Users List:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, i) {
                  final user = users[i];
                  return Card(
                    child: ListTile(
                      title: Text('${user['name']} (${user['role']})'),
                      subtitle: Text(
                        'Email: ${user['email']}\nAge: ${user['age']} | Dept: ${user['department']}',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteUser(user['id']),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
