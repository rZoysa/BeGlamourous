import 'dart:convert';
import 'dart:io';
import 'package:be_glamourous/services/api_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const secureStorage = FlutterSecureStorage();
final String apiURL = apiUrl();

class SocialPlatformService {
  // Method to fetch posts
  Future<List<dynamic>> fetchPosts({int offset = 0, int limit = 30}) async {
    final String? userID = await secureStorage.read(key: 'userID');
    try {
      final response = await http.get(Uri.parse(
          '$apiURL/api/posts?userId=$userID&offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  // Method to toggle like
  Future<bool> toggleLike(String postId) async {
    final String? userID = await secureStorage.read(key: 'userID');

    try {
      final response = await http.post(
        Uri.parse('$apiURL/api/posts/$postId/like'),
        body: jsonEncode({'userId': userID}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['liked'];
      } else {
        throw Exception('Failed to update like status');
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

  // Method to add a post
  Future<bool> addPost(String postText, File? imageFile) async {
    final String? userID = await secureStorage.read(key: 'userID');
    var request = http.MultipartRequest('POST', Uri.parse('$apiURL/api/add-posts'));

    request.fields['userId'] = userID ?? '';
    request.fields['content'] = postText;

    // If there is an image, add it to the request
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'), // Update content type as per image format
      ));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add post');
    }
  } 
}
