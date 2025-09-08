import 'dart:convert';
import 'package:http/http.dart' as http;
import '../assets/piscum_image.dart';

class PicsumRepository {
  Future<List<PicsumImage>> fetchImages({int limit = 10}) async {
    final url = Uri.parse('https://picsum.photos/v2/list?limit=$limit');
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final List<dynamic> body = jsonDecode(resp.body);
      return body.map((e) => PicsumImage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}
