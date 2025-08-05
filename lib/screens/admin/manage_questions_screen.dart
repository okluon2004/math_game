import 'package:flutter/material.dart';

class ManageQuestionsScreen extends StatefulWidget {
  const ManageQuestionsScreen({super.key});

  @override
  State<ManageQuestionsScreen> createState() => _ManageQuestionsScreenState();
}

class _ManageQuestionsScreenState extends State<ManageQuestionsScreen> {
  final List<Map<String, String>> questions = [
    {'content': '2 + 2 = ?', 'type': 'Trắc nghiệm', 'level': 'Dễ'},
    {'content': 'Giải phương trình x^2 - 4x + 4 = 0', 'type': 'Tự luận', 'level': 'Trung bình'},
  ];
  String search = '';

  void _addQuestion() {
    showDialog(
      context: context,
      builder: (_) {
        String content = '';
        String type = 'Trắc nghiệm';
        String level = 'Dễ';
        return AlertDialog(
          title: const Text('Thêm câu hỏi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nội dung câu hỏi'),
                onChanged: (val) => content = val,
              ),
              DropdownButton<String>(
                value: type,
                items: const [
                  DropdownMenuItem(value: 'Trắc nghiệm', child: Text('Trắc nghiệm')),
                  DropdownMenuItem(value: 'Tự luận', child: Text('Tự luận')),
                ],
                onChanged: (val) => setState(() => type = val!),
              ),
              DropdownButton<String>(
                value: level,
                items: const [
                  DropdownMenuItem(value: 'Dễ', child: Text('Dễ')),
                  DropdownMenuItem(value: 'Trung bình', child: Text('Trung bình')),
                  DropdownMenuItem(value: 'Khó', child: Text('Khó')),
                ],
                onChanged: (val) => setState(() => level = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  questions.add({'content': content, 'type': type, 'level': level});
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

  void _editQuestion(int index) {
    showDialog(
      context: context,
      builder: (_) {
        String content = questions[index]['content']!;
        String type = questions[index]['type']!;
        String level = questions[index]['level']!;
        return AlertDialog(
          title: const Text('Sửa câu hỏi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: content),
                decoration: const InputDecoration(labelText: 'Nội dung câu hỏi'),
                onChanged: (val) => content = val,
              ),
              DropdownButton<String>(
                value: type,
                items: const [
                  DropdownMenuItem(value: 'Trắc nghiệm', child: Text('Trắc nghiệm')),
                  DropdownMenuItem(value: 'Tự luận', child: Text('Tự luận')),
                ],
                onChanged: (val) => setState(() => type = val!),
              ),
              DropdownButton<String>(
                value: level,
                items: const [
                  DropdownMenuItem(value: 'Dễ', child: Text('Dễ')),
                  DropdownMenuItem(value: 'Trung bình', child: Text('Trung bình')),
                  DropdownMenuItem(value: 'Khó', child: Text('Khó')),
                ],
                onChanged: (val) => setState(() => level = val!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  questions[index] = {'content': content, 'type': type, 'level': level};
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

  void _deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = questions.where((q) => q['content']!.contains(search)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý câu hỏi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Tìm kiếm câu hỏi'),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final q = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: Text(q['content']!),
                  subtitle: Text('Dạng: ${q['type']} - Độ khó: ${q['level']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editQuestion(questions.indexOf(q)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteQuestion(questions.indexOf(q)),
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
              onPressed: _addQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Thêm câu hỏi'),
            ),
          ),
        ],
      ),
    );
  }
}