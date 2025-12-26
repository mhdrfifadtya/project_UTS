import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class AuthService {
  // ================= LOGIN =================
  static Future<bool> login({
    required String email,
    required String password,
    required String role, // job_seeker | company
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];

        if (token != null && user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', user['role']);
          await prefs.setInt('user_id', user['id']);
          print('Login sukses: token & user disimpan');
          return true;
        } else {
          print('Token atau user null');
          return false;
        }
      } else {
        print('Login gagal: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // ================= REGISTER =================
  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String role, // job_seeker | company
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'role': role,
        }),
      );

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  // ================= LOGOUT =================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        await http.post(
          Uri.parse('${ApiConfig.baseUrl}/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      } catch (e) {
        print('Logout error: $e');
      }
    }

    await prefs.clear();
    print('Logout berhasil, SharedPreferences dihapus');
  }

  // ================= GET TOKEN =================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // ================= GET ROLE =================
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }
}
