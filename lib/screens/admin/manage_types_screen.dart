import 'package:flutter/material.dart';

class ManageTypesScreen extends StatefulWidget {
  const ManageTypesScreen({super.key});

  @override
  State<ManageTypesScreen> createState() => _ManageTypesScreenState();
}

class _ManageTypesScreenState extends State<ManageTypesScreen> {
  final List<String> types = ['Trắc nghiệm', 'Tự luận'];
  String search = '';

  void _addType() {
    showDialog(
      context: context,
      builder: (_) {
        String type = '';
        return AlertDialog(
          title: const Text('Thêm dạng bài'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Tên dạng bài'),
            onChanged: (val) => type = val,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  types.add(type);
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

  void _editType(int index) {
    showDialog(
      context: context,
      builder: (_) {
        String type = types[index];
        return AlertDialog(
          title: const Text('Sửa dạng bài'),
          content: TextField(
            controller: TextEditingController(text: type),
            decoration: const InputDecoration(labelText: 'Tên dạng bài'),
            onChanged: (val) => type = val,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  types[index] = type;
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

  void _deleteType(int index) {
    setState(() {
      types.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = types.where((t) => t.contains(search)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý dạng bài')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Tìm kiếm dạng bài'),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final t = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(t),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editType(types.indexOf(t)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteType(types.indexOf(t)),
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
              onPressed: _addType,
              icon: const Icon(Icons.add),
              label: const Text('Thêm dạng bài'),
            ),
          ),
        ],
      ),
    );
  }
}