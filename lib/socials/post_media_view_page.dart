import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webtoons/components/my_bottom_navigation_bar.dart';
import 'package:webtoons/constants.dart';

class PostMediaViewPage extends StatefulWidget {
  final String? mediaId;
  final String? postId;

  const PostMediaViewPage({
    super.key,
    required this.mediaId,
    required this.postId,
  });

  @override
  State<PostMediaViewPage> createState() => _PostMediaViewPageState();
}

class _PostMediaViewPageState extends State<PostMediaViewPage> {
  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  // Scroll controller for carousel
  late InfiniteScrollController _mainController;

  // Maintain current index of carousel
  int _mainControllerselectedIndex = 0;

  // Width of each item
  double? _mainCarouselItemWidth;

  Color heartIconColor = Colors.grey;
  IconData bookmarkIcon = Icons.bookmark_border_outlined;

  @override
  void initState() {
    super.initState();
    _mainController = InfiniteScrollController(
      initialItem: _mainControllerselectedIndex,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mainCarouselItemWidth = screenWidth;
  }

  @override
  void dispose() {
    super.dispose();
    _mainController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('LAYA', automaticallyImplyLeading: true),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/250?image=1',
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.025),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "name ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {},
                                child: const Text(
                                  "@username ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                child: const Text('Follow'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.5,
                child: InfiniteCarousel.builder(
                  center: true,
                  velocityFactor: 0.75,
                  itemCount: kDemoImages.length,
                  itemExtent: _mainCarouselItemWidth ?? 50,
                  scrollBehavior: kIsWeb
                      ? ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            // Allows to swipe in web browsers
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        )
                      : null,
                  loop: false,
                  controller: _mainController,
                  onIndexChanged: (index) {
                    if (_mainControllerselectedIndex != index) {
                      setState(() => _mainControllerselectedIndex = index);
                    }
                  },
                  itemBuilder: (context, itemIndex, realIndex) {
                    return GestureDetector(
                      onTap: () => _mainController.animateToItem(realIndex),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/250?image=${widget.mediaId}',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        LucideIcons.messageCircle,
                        size: screenHeight * 0.02,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          heartIconColor = heartIconColor == Colors.grey
                              ? Colors.red
                              : Colors.grey;
                        });
                      },
                      child: Icon(
                        LucideIcons.heart,
                        color: heartIconColor,
                        size: screenHeight * 0.02,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        LucideIcons.reply,
                        size: screenHeight * 0.02,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          bookmarkIcon =
                              bookmarkIcon == Icons.bookmark_border_outlined
                                  ? Icons.bookmark_outlined
                                  : Icons.bookmark_border_outlined;
                        });
                      },
                      child: Icon(
                        bookmarkIcon,
                        size: screenHeight * 0.02,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        LucideIcons.share,
                        size: screenHeight * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(index: 0),
    );
  }
}
