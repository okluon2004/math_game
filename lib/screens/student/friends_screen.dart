import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final List<Map<String, dynamic>> friends = [
    {'name': 'Nguyễn Văn A', 'online': true},
    {'name': 'Trần Thị B', 'online': false},
    {'name': 'Lê Văn C', 'online': true},
  ];

  void _removeFriend(int index) {
    setState(() {
      friends.removeAt(index);
    });
  }

  void _addFriend() {
    showDialog(
      context: context,
      builder: (_) {
        String newFriend = '';
        return AlertDialog(
          title: const Text('Thêm bạn'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Tên bạn'),
            onChanged: (val) => newFriend = val,
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Thêm'),
              onPressed: () {
                if (newFriend.isNotEmpty) {
                  setState(() {
                    friends.add({'name': newFriend, 'online': false});
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cập nhật thông tin cá nhân')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết bạn & Quản lý tài khoản')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Thêm bạn mới'),
            onTap: _addFriend,
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: friends.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final friend = friends[index];
                return ListTile(
                  leading: Icon(
                    friend['online'] ? Icons.circle : Icons.circle_outlined,
                    color: friend['online'] ? Colors.green : Colors.grey,
                  ),
                  title: Text(friend['name']),
                  subtitle: friend['online'] ? const Text('Đang hoạt động') : const Text('Offline'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeFriend(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: _updateProfile,
            icon: const Icon(Icons.edit),
            label: const Text('Cập nhật thông tin cá nhân'),
          ),
        ],
      ),
    );
  }
}