import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu thống kê giả lập
    final stats = [
      {'title': 'Tổng thời gian học', 'value': '15h 30p'},
      {'title': 'Điểm TB', 'value': '8.2'},
      {'title': 'Tốc độ TB', 'value': '5p/bài'},
      {'title': 'Chuỗi ngày học', 'value': '7 ngày liên tiếp'},
      {'title': 'Tổng điểm các bài học', 'value': '120 điểm'},
      {'title': 'BXH', 'value': 'Top 3 lớp'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Thống kê')),
      body: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.analytics),
            title: Text(stats[index]['title']!),
            trailing: Text(stats[index]['value']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}