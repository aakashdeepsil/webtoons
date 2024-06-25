import 'package:flutter/material.dart';

import 'package:lucide_icons/lucide_icons.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  Color heartIconColor = Colors.grey;
  IconData bookmarkIcon = Icons.bookmark_border_outlined;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        const Text(
                          "1h ago",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.person_add_alt_1_outlined,
                                      ),
                                      title: Text('Follow User'),
                                    ),
                                    ListTile(
                                      leading: Icon(LucideIcons.copy),
                                      title: Text('Copy link'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.block),
                                      title: Text('Block User'),
                                    ),
                                    ListTile(
                                      leading: Icon(LucideIcons.flag),
                                      title: Text('Report Post'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            LucideIcons.moreVertical,
                            size: screenHeight * 0.017,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio nec nunc.",
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                      ),
                      child: Image.network(
                        'https://picsum.photos/250?image=2',
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
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
                                bookmarkIcon = bookmarkIcon ==
                                        Icons.bookmark_border_outlined
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
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
