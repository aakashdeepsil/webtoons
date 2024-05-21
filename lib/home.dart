import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:webtoons/theme/theme_provider.dart';

import 'constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Wheater to loop through elements
  final bool _loop = true;

  // Scroll controller for carousel
  late InfiniteScrollController _mainController;
  late InfiniteScrollController _topWebToonsController;

  // Maintain current index of carousel
  int _mainControllerselectedIndex = 0;
  int _topWebToonsControllerselectedIndex = 0;

  // Width of each item
  double? _mainCarouselItemWidth;
  double? _topWebToonsCarouselItemWidth;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _mainController =
        InfiniteScrollController(initialItem: _mainControllerselectedIndex);
    _topWebToonsController = InfiniteScrollController(
      initialItem: _topWebToonsControllerselectedIndex,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mainCarouselItemWidth = screenWidth;
    _topWebToonsCarouselItemWidth = screenWidth - 300;
  }

  @override
  void dispose() {
    super.dispose();
    _mainController.dispose();
  }

  List<String> kDemoImages = [
    'https://i.pinimg.com/originals/7f/91/a1/7f91a18bcfbc35570c82063da8575be8.jpg',
    'https://www.absolutearts.com/portfolio3/a/afifaridasiddique/Still_Life-1545967888l.jpg',
    'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/53415/72138/1597120261997_IMG_20200811_095922__49127.1597493165.jpg?c=2',
    'https://i.pinimg.com/originals/47/7e/15/477e155db1f8f981c4abb6b2f0092836.jpg',
    'https://images.saatchiart.com/saatchi/770124/art/3760260/2830144-QFPTZRUH-7.jpg',
    'https://images.unsplash.com/photo-1471943311424-646960669fbc?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3RpbGwlMjBsaWZlfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
    'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/40895/55777/1526876829723_P211_24X36__2018_Stilllife_15000_20090__91926.1563511650.jpg?c=2',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIUsxpakPiqVF4W_rOlq6eoLYboOFoxw45qw&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('LAYA'),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: InfiniteCarousel.builder(
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
                loop: _loop,
                controller: _mainController,
                onIndexChanged: (index) {
                  if (_mainControllerselectedIndex != index) {
                    setState(() {
                      _mainControllerselectedIndex = index;
                    });
                  }
                },
                itemBuilder: (context, itemIndex, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        _mainController.animateToItem(realIndex);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: kElevationToShadow[2],
                          image: DecorationImage(
                            image: NetworkImage(kDemoImages[itemIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Top WebToons',
            ),
            SizedBox(
              height: 200,
              child: InfiniteCarousel.builder(
                itemCount: kDemoImages.length,
                itemExtent: _topWebToonsCarouselItemWidth ?? 50,
                scrollBehavior: kIsWeb
                    ? ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          // Allows to swipe in web browsers
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      )
                    : null,
                loop: _loop,
                controller: _topWebToonsController,
                onIndexChanged: (index) {
                  if (_topWebToonsControllerselectedIndex != index) {
                    setState(() {
                      _topWebToonsControllerselectedIndex = index;
                    });
                  }
                },
                itemBuilder: (context, itemIndex, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        _topWebToonsController.animateToItem(realIndex);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(kDemoImages[itemIndex]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('WebToon Title'),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              child: const Text(
                'Toggle Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.home),
              label: 'Home',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.search),
              label: 'Explore',
              tooltip: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.library),
              label: 'Library',
              tooltip: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.userCircle),
              label: 'Profile',
              tooltip: 'Profile',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
