import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Thông tin cá nhân mẫu
    final Map<String, String> info = {
      'Tên': 'Nguyễn Văn A',
      'Email': 'a.nguyen@example.com',
      'Lớp': 'Toán 10',
      'Vai trò': 'Học sinh',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin cá nhân')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: info.entries.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 100, child: Text('${e.key}:', style: const TextStyle(fontWeight: FontWeight.bold))),
                Text(e.value),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}