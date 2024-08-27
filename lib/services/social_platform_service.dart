import 'dart:convert';
import 'package:be_glamourous/services/api_url.dart';
import 'package:http/http.dart' as http;

final String apiURL = apiUrl();

class SocialPlatformService {
  // Method to fetch posts
  Future<List<dynamic>> fetchPosts({int offset = 0, int limit = 30}) async {
    try {
      final response = await http
          .get(Uri.parse('$apiURL/api/posts?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

// Method to fetch comments
  Future<List<dynamic>> fetchCommentsForPost(String postId) async {
    try {
      final response =
          await http.get(Uri.parse('$apiURL/api/posts/$postId/comments'));
      if (response.statusCode == 200) {
        // Logger().e(response.body);
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
