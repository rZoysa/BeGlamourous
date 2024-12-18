import 'dart:io';

import 'package:be_glamourous/Screens/social_platform_screen/widgets/add_post_section.dart';
import 'package:be_glamourous/Screens/social_platform_screen/widgets/social_post.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/providers/social_platform_provider.dart';
import 'package:be_glamourous/services/api_url.dart';
import 'package:be_glamourous/services/social_platform_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SocialPlatformScreen extends StatefulWidget {
  const SocialPlatformScreen({super.key});

  @override
  State<SocialPlatformScreen> createState() => _SocialPlatformScreenState();
}

class _SocialPlatformScreenState extends State<SocialPlatformScreen> {
  final ScrollController _scrollController = ScrollController();
  final String imageURL = '${apiUrl()}/api/post-image/';
  final String profilePicURL = '${apiUrl()}/api/profile-picture/';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SocialPostsProvider>(context, listen: false);
      if (provider.posts.isEmpty) {
        provider.fetchPosts();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<SocialPostsProvider>(context, listen: false).fetchPosts();
      }
    });
  }

  Future<void> _refreshPosts() async {
    await Provider.of<SocialPostsProvider>(context, listen: false)
        .fetchPosts(isRefresh: true);
  }

  void _showAddPostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddPostSection(
          onPost: (String postText, File? imageFile) async {
            await _addPost(postText, imageFile);
          },
        );
      },
    );
  }

  Future<void> _addPost(String postText, File? imageFile) async {
    try {
      bool success = await SocialPlatformService().addPost(postText, imageFile);
      if (success && mounted) {
        Provider.of<SocialPostsProvider>(context, listen: false).fetchPosts();
      }
    } catch (e) {
      Logger().e('Error adding post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      body: Consumer<SocialPostsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.posts.isEmpty) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 12,
              animating: true,
            ));
          }

          if (provider.posts.isEmpty) {
            return LiquidPullToRefresh(
              showChildOpacityTransition: false,
              backgroundColor: Colors.white,
              color: const Color.fromARGB(60, 0, 0, 0),
              height: 40,
              onRefresh: _refreshPosts,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const Center(
                    child: Text(
                      'No posts available',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jura',
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            backgroundColor: Colors.white,
            color: const Color.fromARGB(60, 0, 0, 0),
            height: 40,
            onRefresh: _refreshPosts,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _showAddPostBottomSheet(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          color: Colors.white54,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Share Your Thoughts...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Jura',
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: provider.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == provider.posts.length) {
                        return provider.hasMorePosts
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 80),
                                child: const Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                    radius: 12,
                                    animating: true,
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 80),
                                child: const Text(
                                  'You reached the end of the page',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'Jura'),
                                ),
                              );
                      } else {
                        final post = provider.posts[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SocialPost(
                            postID: post['postID'].toString(),
                            imageUrls: List<String>.from(post['imageIds']
                                .map((id) => imageURL + id.toString())),
                            caption: post['content'] as String,
                            timeStamp: post['timestamp'] as String,
                            userName:
                                '${post['firstName']} ${post['lastName']}',
                            userProfilePicURL: post['profilePictureId'] != null
                                ? profilePicURL +
                                    post['profilePictureId'].toString()
                                : '',
                            likedCount: post['like_count'],
                            userLikedStatus: post['liked'],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
