import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String password = '';
  String role = 'student';

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Thực hiện đăng ký tài khoản ở đây
      Navigator.pop(context); // Quay lại màn hình đăng nhập
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Đăng ký tài khoản",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tên người dùng'),
                  onChanged: (val) => username = val,
                  validator: (val) => val!.isEmpty ? "Nhập tên người dùng" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (val) => email = val,
                  validator: (val) => val!.isEmpty ? "Nhập email" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val!.isEmpty ? "Nhập mật khẩu" : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  value: role,
                  decoration: const InputDecoration(labelText: 'Vai trò'),
                  items: const [
                    DropdownMenuItem(value: 'student', child: Text('Học sinh')),
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  ],
                  onChanged: (val) => setState(() => role = val!),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Đăng ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}