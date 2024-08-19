import 'package:be_glamourous/services/social_platform_service.dart';
import 'package:flutter/material.dart';

class SocialPostsProvider with ChangeNotifier {
  final List<dynamic> _posts = [];
  bool _isLoading = true;
  int _offset = 0;
  final int _limit = 30;
  bool _hasMorePosts = true;

  List<dynamic> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMorePosts => _hasMorePosts;

  Future<void> fetchPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      _posts.clear();
      _offset = 0;
      _hasMorePosts = true;
    }

    if (_hasMorePosts) {
      try {
        _isLoading = true;
        notifyListeners();

        var fetchedPosts = await SocialPlatformService()
            .fetchPosts(offset: _offset, limit: _limit);

        if (fetchedPosts.isNotEmpty) {
          _posts.addAll(fetchedPosts);
          _offset += _limit;
        } else {
          _hasMorePosts = false;
        }
      } catch (e) {
        print('Error fetching posts: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
