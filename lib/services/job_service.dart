import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/job_model.dart';

class JobService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // ================== HELPER ==================
  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token tidak ditemukan, silakan login ulang');
    }
    return token;
  }

  // ================== PUBLIC JOBS ==================
  // Untuk Home / Featured Jobs
  static Future<List<Job>> fetchJobs() async {
    final response = await http.get(
      Uri.parse('$baseUrl/jobs'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil job');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw Exception('Format data job tidak valid');
    }

    return decoded.map<Job>((e) => Job.fromJson(e)).toList();
  }

  // ================== COMPANY JOBS ==================
  // (job milik company – masih pakai endpoint /jobs)
  static Future<List<Job>> fetchCompanyJobs() async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/jobs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil job company');
    }

    final decoded = jsonDecode(response.body) as List;
    return decoded.map((e) => Job.fromJson(e)).toList();
  }

  // ================== CREATE JOB ==================
  static Future<void> createJob(Map<String, dynamic> body) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/jobs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal membuat job: ${response.body}');
    }
  }

  // ================== UPDATE JOB ==================
  // METHOD OVERRIDE (AMAN)
  static Future<void> updateJob(int id, Map<String, dynamic> body) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/jobs/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        ...body,
        '_method': 'PUT',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update job: ${response.body}');
    }
  }

  // ================== DELETE JOB ==================
  static Future<void> deleteJob(int id) async {
    final token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/jobs/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus job');
    }
  }
}
