import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Register with email verification
  static Future<Map<String, dynamic>> register(String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      if (user != null) {
        // Update display name
        await user.updateDisplayName(username);
        
        // Send email verification
        await user.sendEmailVerification();
        
        return {
          'success': true,
          'message': 'Tài khoản đã được tạo thành công. Vui lòng kiểm tra email để xác thực tài khoản.',
          'user': user,
        };
      } else {
        return {
          'success': false,
          'message': 'Có lỗi xảy ra khi tạo tài khoản.',
        };
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'Mật khẩu quá yếu.';
          break;
        case 'email-already-in-use':
          message = 'Email này đã được sử dụng.';
          break;
        case 'invalid-email':
          message = 'Email không hợp lệ.';
          break;
        default:
          message = 'Có lỗi xảy ra: ${e.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Có lỗi xảy ra: ${e.toString()}',
      };
    }
  }

  // Login with email verification check
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = result.user;
      if (user != null) {
        // Check if email is verified
        await user.reload(); // Refresh user data
        user = _auth.currentUser; // Get updated user
        
        if (user!.emailVerified) {
          return {
            'success': true,
            'message': 'Đăng nhập thành công.',
            'user': user,
          };
        } else {
          return {
            'success': false,
            'message': 'Email chưa được xác thực. Vui lòng kiểm tra email hoặc gửi lại email xác thực.',
            'needsVerification': true,
            'user': user,
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Có lỗi xảy ra khi đăng nhập.',
        };
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Không tìm thấy tài khoản với email này.';
          break;
        case 'wrong-password':
          message = 'Mật khẩu không đúng.';
          break;
        case 'invalid-email':
          message = 'Email không hợp lệ.';
          break;
        case 'user-disabled':
          message = 'Tài khoản này đã bị vô hiệu hóa.';
          break;
        default:
          message = 'Có lỗi xảy ra: ${e.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Có lỗi xảy ra: ${e.toString()}',
      };
    }
  }

  // Resend email verification
  static Future<Map<String, dynamic>> resendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return {
          'success': true,
          'message': 'Email xác thực đã được gửi lại.',
        };
      } else {
        return {
          'success': false,
          'message': 'Không thể gửi email xác thực.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Có lỗi xảy ra khi gửi email: ${e.toString()}',
      };
    }
  }

  // Logout
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // Check if user is logged in
  static bool get isLoggedIn => _auth.currentUser != null;

  // Check if current user's email is verified
  static bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;
}