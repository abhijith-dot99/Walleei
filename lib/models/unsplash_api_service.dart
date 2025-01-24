import 'dart:convert';
import 'package:http/http.dart' as http;

class UnsplashApiService {
  static const String _apiKey = 'Zac0n4fT8IVFwvSjb5Zd5qJ7336amIqJPCgkk4hvBjjuIN4hsOEspDkm';
  static const String _baseUrl = 'https://api.pexels.com/v1/curated';

  Future<List<dynamic>> fetchImages(int page) async {
    final url = Uri.parse("$_baseUrl?page=$page&per_page=20");
    final response = await http.get(url, headers: {'Authorization': _apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['photos'];
    } else {
      throw Exception('Failed to fetch images');
    }
  }
}
