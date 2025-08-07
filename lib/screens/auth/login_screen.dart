import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../student/student_dashboard.dart';
import '../admin/admin_dashboard.dart';
import '../../services/auth_service.dart';
import '../../google_sign_in_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String role = 'student';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        Map<String, dynamic> result = await AuthService.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          if (result['success']) {
            if (role == 'student') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StudentDashboard()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AdminDashboard()),
              );
            }
          } else if (result['needsVerification'] == true) {
            _showEmailVerificationDialog(result['message']);
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Lỗi đăng nhập'),
                content: Text(result['message']),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Đóng'),
                  ),
                ],
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Lỗi'),
              content: Text('Có lỗi xảy ra: ${e.toString()}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đóng'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  void _showEmailVerificationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Email chưa xác thực'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 16),
            const Text(
              'Bạn có muốn gửi lại email xác thực không?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _resendVerificationEmail();
            },
            child: const Text('Gửi lại'),
          ),
        ],
      ),
    );
  }

  Future<void> _resendVerificationEmail() async {
    try {
      Map<String, dynamic> result = await AuthService.resendEmailVerification();

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(result['success'] ? 'Thành công' : 'Lỗi'),
            content: Text(result['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi'),
            content: Text('Có lỗi xảy ra: ${e.toString()}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 400, // hoặc bạn có thể dùng MediaQuery để responsive
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hệ thống học tập",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty) return "Nhập email";
                      if (!val.contains('@')) return "Email không hợp lệ";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Mật khẩu'),
                    obscureText: true,
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Đăng nhập'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GoogleSignInPage(),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    ),
                    child: const Text('Chưa có tài khoản? Đăng ký'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}