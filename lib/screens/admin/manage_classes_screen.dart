import 'package:flutter/material.dart';

class ManageClassesScreen extends StatefulWidget {
  const ManageClassesScreen({super.key});

  @override
  State<ManageClassesScreen> createState() => _ManageClassesScreenState();
}

class _ManageClassesScreenState extends State<ManageClassesScreen> {
  final List<Map<String, String>> classes = [
    {'name': 'Toán 10', 'desc': 'Lớp Toán cơ bản lớp 10'},
    {'name': 'Toán 11', 'desc': 'Lớp Toán cơ bản lớp 11'},
  ];
  String search = '';

  void _addClass() {
    showDialog(
      context: context,
      builder: (_) {
        String name = '';
        String desc = '';
        return AlertDialog(
          title: const Text('Thêm lớp'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Tên lớp'),
                onChanged: (val) => name = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Mô tả'),
                onChanged: (val) => desc = val,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  classes.add({'name': name, 'desc': desc});
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

  void _editClass(int index) {
    showDialog(
      context: context,
      builder: (_) {
        String name = classes[index]['name']!;
        String desc = classes[index]['desc']!;
        return AlertDialog(
          title: const Text('Sửa lớp'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: name),
                decoration: const InputDecoration(labelText: 'Tên lớp'),
                onChanged: (val) => name = val,
              ),
              TextField(
                controller: TextEditingController(text: desc),
                decoration: const InputDecoration(labelText: 'Mô tả'),
                onChanged: (val) => desc = val,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  classes[index]['name'] = name;
                  classes[index]['desc'] = desc;
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

  void _deleteClass(int index) {
    setState(() {
      classes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = classes.where((c) => c['name']!.contains(search)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý lớp')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Tìm kiếm lớp'),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final c = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.class_),
                  title: Text(c['name']!),
                  subtitle: Text(c['desc']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editClass(classes.indexOf(c)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteClass(classes.indexOf(c)),
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
              onPressed: _addClass,
              icon: const Icon(Icons.add),
              label: const Text('Thêm lớp'),
            ),
          ),
        ],
      ),
    );
  }
}