import 'package:be_glamourous/services/api_url.dart';
import 'package:be_glamourous/services/social_platform_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentSectionBuilder {
  TextEditingController commentController = TextEditingController();

  void showBottomSheet(BuildContext context, String postID) {
    final String profilePicURL = '${apiUrl()}/api/profile-picture/';
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final double sheetHeight = MediaQuery.of(context).size.height * 0.5;
        return FutureBuilder<List<dynamic>>(
          future: SocialPlatformService().fetchCommentsForPost(postID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 75,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF26292D),
                ),
                child: const CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var comments = snapshot.data!;
              return Theme(
                data: ThemeData(fontFamily: 'Jura'),
                child: Container(
                  height: sheetHeight,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(14)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                              const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  color: Color(0xFF26292D),
                ),
                child: Column(
                  children: [
                    // Handle
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 175, vertical: 4),
                      child: Container(
                        height: 4,
                        decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'No comments found',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jura',
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(flex: 1),
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
                                    color: Colors.white54,
                                    fontFamily: 'Jura',
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5)
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
