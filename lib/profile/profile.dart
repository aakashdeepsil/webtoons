import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:webtoons/components/my_bottom_navigation_bar.dart';
import 'package:webtoons/constants.dart';
import 'package:webtoons/profile/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  var _loading = true;

  String avatarUrl = '';
  String bio = '';
  String firstName = '';
  String lastName = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();

      avatarUrl = (data['avatar_url'] ?? '') as String;
      bio = (data['bio'] ?? '') as String;
      firstName = (data['first_name'] ?? '') as String;
      lastName = (data['last_name'] ?? '') as String;
      username = (data['username'] ?? '') as String;
    } on PostgrestException catch (error) {
      if (mounted) {
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBar(
          content: const Text('Unexpected error occurred. Try again.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200] ?? Colors.white,
              ),
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              username,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ProfileHeader(
                              firstName: firstName,
                              lastName: lastName,
                              username: username,
                              bio: bio,
                              avatarUrl: avatarUrl,
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      TabBar(
                        unselectedLabelColor: Colors.grey[400],
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 1,
                        tabs: const [
                          Tab(
                            text: "Text Content",
                          ),
                          Tab(
                            text: "Visual Content",
                          ),
                          Tab(
                            text: "Reviews",
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Post $index"),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Saved $index"),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Saved $index"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
