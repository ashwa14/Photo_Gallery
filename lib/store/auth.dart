import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  // This uses reqres.in as a dummy login endpoint. For real apps replace with your API.
  Future<bool> login({required String email, required String password}) async {
    final url = Uri.parse('https://reqres.in/api/login');
    final resp = await http.post(
      url,
      body: {'email': email, 'password': password},
    );

    if (resp.statusCode == 200) {
      // returns token in body - treat as success
      final data = jsonDecode(resp.body);
      if (data['token'] != null) return true;
    }
    return false;
  }
}
