// ignore_for_file: file_names, unused_import, avoid_print

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:laporan_masyarakat/config.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String fullname, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/login');

    try {
      final response = await http.post(
        url,
        body: {
          'fullname': fullname,
          'password': password,
        },
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        return {
          'status': responseBody['status'],
          'message': responseBody['message'],
          'data': responseBody['data'],
        };
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in AuthService: $e');
    }
    return null;
  }
}
