import 'package:flutter/material.dart';

class ManageAccountsScreen extends StatefulWidget {
  const ManageAccountsScreen({super.key});

  @override
  State<ManageAccountsScreen> createState() => _ManageAccountsScreenState();
}

class _ManageAccountsScreenState extends State<ManageAccountsScreen> {
  final List<Map<String, dynamic>> accounts = [
    {'username': 'hocvien01', 'role': 'student', 'banned': false},
    {'username': 'admin01', 'role': 'admin', 'banned': false},
    {'username': 'hocvien02', 'role': 'student', 'banned': true},
  ];
  String search = '';

  void _addAccount() {
    showDialog(
      context: context,
      builder: (_) {
        String username = '';
        String role = 'student';
        return AlertDialog(
          title: const Text('Thêm tài khoản'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
                onChanged: (val) => username = val,
              ),
              DropdownButton<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Học sinh')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (val) => setState(() => role = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  accounts.add({'username': username, 'role': role, 'banned': false});
                });
                Navigator.pop(context);
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  void _editAccount(int index) {
    showDialog(
      context: context,
      builder: (_) {
        String username = accounts[index]['username'];
        String role = accounts[index]['role'];
        return AlertDialog(
          title: const Text('Sửa tài khoản'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: username),
                decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
                onChanged: (val) => username = val,
              ),
              DropdownButton<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Học sinh')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (val) => setState(() => role = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  accounts[index]['username'] = username;
                  accounts[index]['role'] = role;
                });
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _toggleBan(int index) {
    setState(() {
      accounts[index]['banned'] = !(accounts[index]['banned'] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = accounts
        .where((acc) => acc['username'].contains(search))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý tài khoản')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Tìm kiếm tài khoản'),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final acc = filtered[index];
                return ListTile(
                  leading: Icon(acc['role'] == 'admin' ? Icons.admin_panel_settings : Icons.person),
                  title: Text(acc['username']),
                  subtitle: Text('Quyền: ${acc['role']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(acc['banned'] ? Icons.lock_open : Icons.lock),
                        tooltip: acc['banned'] ? 'Bỏ ban' : 'Ban',
                        onPressed: () => _toggleBan(accounts.indexOf(acc)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editAccount(accounts.indexOf(acc)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              onPressed: _addAccount,
              icon: const Icon(Icons.add),
              label: const Text('Thêm tài khoản'),
            ),
          ),
        ],
      ),
    );
  }
}