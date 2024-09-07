import 'package:be_glamourous/services/api_url.dart';
import 'package:be_glamourous/services/social_platform_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class CommentSectionBuilder {
  TextEditingController commentController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // Function to fetch comments
  Future<List<dynamic>> _fetchComments(String postID) async {
    return await SocialPlatformService().fetchCommentsForPost(postID);
  }

  // Function to post a comment
  Future<void> _postComment(
      String postID, String userID, String content) async {
    final String url = '${apiUrl()}/api/posts/$postID/comment';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userID,
          'content': content,
        }),
      );

      if (response.statusCode == 201) {
        Logger().e('Comment posted successfully');
      } else {
        Logger().e('Failed to post comment: ${response.body}');
      }
    } catch (e) {
      Logger().e('Error posting comment: $e');
    }
  }

  // Function to show the bottom sheet
  void showBottomSheet(BuildContext context, String postID) async {
    final String profilePicURL = '${apiUrl()}/api/profile-picture/';

    // Fetch the userID from secure storage
    String? userID = await secureStorage.read(key: 'userID');

    // Check if userID is available
    if (userID == null) {
      Logger().e("User ID not found in secure storage.");
      return;
    }

    // Fetch the comments first
    List<dynamic> comments = await _fetchComments(postID);

    // Check if the widget is still mounted before showing the bottom sheet
    if (!context.mounted) return;

    // Then show the bottom sheet
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Important for the keyboard interaction
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom), // Adjust the bottom padding to avoid keyboard overlap
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                color: Color(0xFF26292D),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 175, vertical: 6),
                    child: Container(
                      height: 4,
                      decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.4, // Set height to ensure enough room for scrolling
                    child: comments.isNotEmpty
                        ? ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              var comment = comments[index];
                              return ListTile(
                                leading: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: comment['pictureID'] != null
                                          ? NetworkImage(profilePicURL +
                                              comment['pictureID'].toString())
                                          : const AssetImage(
                                              'assets/images/default_profile_icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    '${comment['firstName']} ${comment['lastName']}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 2, bottom: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    comment['content'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Column(
                            children: [
                              Spacer(),
                              Text(
                                'No comments found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Jura',
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(flex: 1),
                            ],
                          ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 0,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: Colors.white54,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Post a comment...",
                                hintStyle: TextStyle(
                                  fontFamily: 'Jura',
                                  color: Colors.white54,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () async {
                              // Get the comment text and send it to the backend
                              final String content = commentController.text;
                              if (content.isNotEmpty) {
                                await _postComment(postID, userID, content);
                                commentController.clear();

                                // Check if the widget is still mounted
                                if (!context.mounted) return;

                                // Optionally refresh comments after posting
                                comments = await _fetchComments(postID);
                                if (!context.mounted) return;
                                // Update UI after sending the comment
                                Navigator.of(context).pop();
                                showBottomSheet(context,
                                    postID); // Reopen the updated comment sheet
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
