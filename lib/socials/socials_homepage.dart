import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webtoons/components/my_bottom_navigation_bar.dart';
import 'package:webtoons/constants.dart';
import 'package:webtoons/socials/components/post.dart';

class SocialsHomepage extends StatefulWidget {
  const SocialsHomepage({super.key});

  @override
  State<SocialsHomepage> createState() => _SocialsHomepageState();
}

class _SocialsHomepageState extends State<SocialsHomepage> {
  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('LAYA'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, _) {
              return [
                SliverList(delegate: SliverChildListDelegate([])),
              ];
            },
            body: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.grey[400],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1,
                  tabs: const [
                    Tab(text: "For You"),
                    Tab(text: "Following"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.go('/socials/post/$index');
                            },
                            child: Post(postId: index.toString()),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Post(postId: index.toString());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(index: 2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(LucideIcons.pencil),
      ),
    );
  }
}
