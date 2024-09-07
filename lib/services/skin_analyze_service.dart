import 'dart:convert';
import 'package:be_glamourous/services/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class SkinAnalyzeService {
  // Add your server URL here
  final String apiURL = apiUrl(); // Replace with your server's base URL

  // Function to save scores to the database
  Future<void> saveScoresToDatabase({
    required int userID,
    required double acneScore,
    required double bagsScore,
    required double rednessScore,
    required double overallHealthScore,
  }) async {
    // Prepare the data to send in the POST request
    Map<String, dynamic> data = {
      'userID': userID,
      'acne_score': acneScore,
      'bags_score': bagsScore,
      'redness_score': rednessScore,
      'overall_health_score': overallHealthScore,
    };

    try {
      // Make a POST request to the backend API
      final response = await http.post(
        Uri.parse('$apiURL/api/save-skin-analysis'), // Backend API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Logger().i('Scores saved successfully');
      } else {
        Logger().e('Failed to save scores: ${response.body}');
      }
    } catch (error) {
      Logger().e('Error occurred while saving scores: $error');
    }
  }
}
