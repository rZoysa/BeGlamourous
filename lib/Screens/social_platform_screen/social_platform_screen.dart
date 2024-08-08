import 'package:be_glamourous/Screens/social_platform_screen/widgets/social_post.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:flutter/material.dart';

class SocialPlatformScreen extends StatefulWidget {
  const SocialPlatformScreen({super.key});

  @override
  State<SocialPlatformScreen> createState() => _SocialPlatformScreenState();
}

class _SocialPlatformScreenState extends State<SocialPlatformScreen> {
  final List<String> imageUrls = [
    'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/masterpieces/veneno/veneno_over_rev_01_m.jpg',
    'https://i.pinimg.com/736x/f8/14/cb/f814cb5f083156598ba67293cc630166.jpg',
    'https://assets.porsche.com/rs/beograd/-/media/Project/DealerWebsites/SharedDealersWebsite/Master-Model-Page/911-GT3-RS/Header/911-gt3-rs-desktop.jpg?rev=-1',
    'https://cdn.motor1.com/images/mgl/qkkj81/s3/porsche-911-gt3-rs-2022.jpg',
    'https://live.staticflickr.com/65535/52427589980_51110c8586_c.jpg',
    'https://www.topgear.com/sites/default/files/2023/03/1-Aston-Martin-Valkyrie.jpg',
  ];

  final posts = [
    {
      'postID': '1',
      'imageURls': [
        'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/masterpieces/veneno/veneno_over_rev_01_m.jpg',
        'https://i.pinimg.com/736x/f8/14/cb/f814cb5f083156598ba67293cc630166.jpg'
      ],
      'caption': 'Hello World',
      'timeStamp': '24 Jul 2024',
      'userName': 'John Doe',
      'userProfilePicture':
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    },
    {
      'postID': '2',
      'imageURls': [
        'https://cdn.motor1.com/images/mgl/qkkj81/s3/porsche-911-gt3-rs-2022.jpg',
        'https://live.staticflickr.com/65535/52427589980_51110c8586_c.jpg',
        'https://www.topgear.com/sites/default/files/2023/03/1-Aston-Martin-Valkyrie.jpg',
      ],
      'caption': 'I like be glamourous.',
      'timeStamp': '14 Jun 2024',
      'userName': 'Jenna',
      'userProfilePicture':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDB-WkjFaTJQjkw1YeocCS4tFC0BP6bCkmBQ&s'
    },
    {
      'postID': '3',
      'imageURls': [
        'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/masterpieces/veneno/veneno_over_rev_01_m.jpg',
        'https://i.pinimg.com/736x/f8/14/cb/f814cb5f083156598ba67293cc630166.jpg',
        'https://assets.porsche.com/rs/beograd/-/media/Project/DealerWebsites/SharedDealersWebsite/Master-Model-Page/911-GT3-RS/Header/911-gt3-rs-desktop.jpg?rev=-1',
        'https://cdn.motor1.com/images/mgl/qkkj81/s3/porsche-911-gt3-rs-2022.jpg',
        'https://live.staticflickr.com/65535/52427589980_51110c8586_c.jpg',
        'https://www.topgear.com/sites/default/files/2023/03/1-Aston-Martin-Valkyrie.jpg',
      ],
      'caption': 'Be glamourous is really good.',
      'timeStamp': '10 Dec 2024',
      'userName': 'Chris',
      'userProfilePicture':
          'https://designimages.appypie.com/profilepicture/profilepicture-2-portrait-head.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return Container(
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
                  final post = posts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: SocialPost(
                      postID: post['postID'] as String,
                      imageUrls: post['imageURls'] as List<String>,
                      caption: post['caption'] as String,
                      timeStamp: post['timeStamp'] as String,
                      userName: post['userName'] as String,
                      userProfilePicURL: post['userProfilePicture'] as String,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
