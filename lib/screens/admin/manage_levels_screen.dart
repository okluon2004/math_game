import 'package:flutter/material.dart';

class ManageLevelsScreen extends StatefulWidget {
  const ManageLevelsScreen({super.key});

  @override
  State<ManageLevelsScreen> createState() => _ManageLevelsScreenState();
}

class _ManageLevelsScreenState extends State<ManageLevelsScreen> {
  final List<String> levels = ['Dễ', 'Trung bình', 'Khó'];
  String search = '';

  void _addLevel() {
    showDialog(
      context: context,
      builder: (_) {
        String level = '';
        return AlertDialog(
          title: const Text('Thêm độ khó'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Tên độ khó'),
            onChanged: (val) => level = val,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  levels.add(level);
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

  void _editLevel(int index) {
    showDialog(
      context: context,
      builder: (_) {
        String level = levels[index];
        return AlertDialog(
          title: const Text('Sửa độ khó'),
          content: TextField(
            controller: TextEditingController(text: level),
            decoration: const InputDecoration(labelText: 'Tên độ khó'),
            onChanged: (val) => level = val,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  levels[index] = level;
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

  void _deleteLevel(int index) {
    setState(() {
      levels.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = levels.where((lv) => lv.contains(search)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý độ khó')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Tìm kiếm độ khó'),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final lv = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.layers),
                  title: Text(lv),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editLevel(levels.indexOf(lv)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteLevel(levels.indexOf(lv)),
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
              onPressed: _addLevel,
              icon: const Icon(Icons.add),
              label: const Text('Thêm độ khó'),
            ),
          ),
        ],
      ),
    );
  }
}