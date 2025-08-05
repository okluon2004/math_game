import 'package:flutter/material.dart';
import 'manage_accounts_screen.dart';
import 'manage_classes_screen.dart';
import 'manage_types_screen.dart';
import 'manage_levels_screen.dart';
import 'manage_questions_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ Admin')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Quản lý tài khoản'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ManageAccountsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.class_),
            title: const Text('Quản lý lớp'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ManageClassesScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Quản lý dạng bài'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ManageTypesScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.layers),
            title: const Text('Quản lý độ khó'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ManageLevelsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Quản lý câu hỏi'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ManageQuestionsScreen())),
          ),
        ],
      ),
    );
  }
}