import 'package:be_glamourous/Screens/social_platform_screen/post_image_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialPost extends StatefulWidget {
  const SocialPost({super.key});

  @override
  State<SocialPost> createState() => _SocialPostState();
}

class _SocialPostState extends State<SocialPost> {
  final List<String> imageUrls = [
    'https://www.lamborghini.com/sites/it-en/files/DAM/lamborghini/masterpieces/veneno/veneno_over_rev_01_m.jpg',
    'https://i.pinimg.com/736x/f8/14/cb/f814cb5f083156598ba67293cc630166.jpg',
    'https://assets.porsche.com/rs/beograd/-/media/Project/DealerWebsites/SharedDealersWebsite/Master-Model-Page/911-GT3-RS/Header/911-gt3-rs-desktop.jpg?rev=-1',
    'https://cdn.motor1.com/images/mgl/qkkj81/s3/porsche-911-gt3-rs-2022.jpg',
    'https://live.staticflickr.com/65535/52427589980_51110c8586_c.jpg',
    'https://www.topgear.com/sites/default/files/2023/03/1-Aston-Martin-Valkyrie.jpg',
  ];

  Widget buildImages() {
    int count = imageUrls.length;
    if (count == 1) {
      return Image.network(imageUrls[0],
          width: double.infinity, fit: BoxFit.cover);
    } else if (count == 3) {
      // Handling 3 images: one on top and two below
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Image.network(imageUrls[0],
                width: double.infinity, height: 200, fit: BoxFit.cover),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 2.5),
                  child: Image.network(imageUrls[1], fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 2.5),
                  child: Image.network(imageUrls[2], fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (count == 2) {
      return Row(
        children: imageUrls
            .map((url) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    child: Image.network(url, fit: BoxFit.cover),
                  ),
                ))
            .toList(),
      );
    } else {
      int gridCount = (count > 4) ? 4 : count;
      return GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          childAspectRatio: 1.4, // Aspect ratio of each grid cell
          crossAxisSpacing: 5, // Horizontal space between items
          mainAxisSpacing: 5, // Vertical space between items
        ),
        itemCount: gridCount,
        itemBuilder: (context, index) {
          bool isLast = index == gridCount - 1 && count > 4;
          return isLast
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrls[index], fit: BoxFit.cover),
                    Container(
                      color: Colors.black45,
                      alignment: Alignment.center,
                      child: Text(
                        '+${count - 3}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              : Image.network(imageUrls[index], fit: BoxFit.cover);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(10, 255, 255, 255),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/default_profile_icon.png',
                    alignment: Alignment.center,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jura',
                        ),
                      ),
                      Text(
                        '24 Jul 2024',
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Jura',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Text(
            'Caption',
            style: TextStyle(
              fontFamily: 'Jura',
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PostImageViewScreen(imageList: imageUrls);
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: buildImages(),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Like',
                      style: TextStyle(fontFamily: 'Jura', color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      CupertinoIcons.chat_bubble_fill,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Comment',
                      style: TextStyle(fontFamily: 'Jura', color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
