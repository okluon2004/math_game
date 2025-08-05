import 'package:flutter/material.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  String selectedClass = 'Toán 10';
  String selectedType = 'Trắc nghiệm';
  String selectedLevel = 'Dễ';

  final classes = ['Toán 10', 'Toán 11', 'Toán 12'];
  final types = ['Trắc nghiệm', 'Tự luận'];
  final levels = ['Dễ', 'Trung bình', 'Khó'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Học tập')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chọn lớp:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedClass,
              items: classes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedClass = val!),
            ),
            const SizedBox(height: 12),
            const Text('Chọn dạng bài:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedType,
              items: types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedType = val!),
            ),
            const SizedBox(height: 12),
            const Text('Chọn độ khó:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedLevel,
              items: levels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedLevel = val!),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Chuyển sang màn làm bài
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Bắt đầu làm bài'),
                      content: Text('Bắt đầu làm bài: $selectedClass - $selectedType - $selectedLevel'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đồng ý')),
                      ],
                    ),
                  );
                },
                child: const Text('Làm bài'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}