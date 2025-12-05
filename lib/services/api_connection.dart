import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiConnection {
  static String proxy(String url) {
    return "https://corsproxy.io/?$url";
  }

  static Future<Map<String, dynamic>?> fetchToday(String apiKey) async {
    final Uri url = Uri.parse(
      proxy("https://api.nasa.gov/planetary/apod?api_key=$apiKey"),
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    return null;
  }

  static Future<Map<String, dynamic>?> fetchByDate(
      String apiKey, String date) async {
    final Uri url = Uri.parse(
      proxy("https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date"),
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    return null;
  }
}
