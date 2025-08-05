import 'package:flutter/material.dart';
import 'statistics_screen.dart';
import 'study_screen.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ Học sinh')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Thống kê'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const StatisticsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Học tập'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const StudyScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Kết bạn & Quản lý tài khoản'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const FriendsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Thông tin cá nhân'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
        ],
      ),
    );
  }
}