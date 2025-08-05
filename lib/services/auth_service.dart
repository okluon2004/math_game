class AuthService {
  // Dummy login for demo
  static Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Replace logic with real authentication
    return email.isNotEmpty && password.isNotEmpty;
  }

  // Dummy register for demo
  static Future<bool> register(String username, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Replace logic with real registration
    return username.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }

  // Dummy logout
  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}