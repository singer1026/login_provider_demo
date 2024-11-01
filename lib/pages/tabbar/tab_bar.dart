import 'package:flutter/material.dart';
import 'package:login_provider_demo/pages/home/home_provider.dart';
import 'package:login_provider_demo/pages/tabbar/tab_provider.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import '../profile/profile_page.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  // List<Widget> _buildPages() {
  //   return [
  //     const HomePage(),
  //     const ProfilePage(),
  //   ];
  final List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) => const HomePage(),
    ),
    // const HomePage(),
    const ProfilePage(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 0,
        length: 2,
        animationDuration: Duration.zero,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TabProvider(_tabController),
      builder: (context, child) {
        return Scaffold(
          body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages),
          bottomNavigationBar: Consumer<TabProvider>(
            builder: (context, tabProvider, child) {
              return BottomNavigationBar(
                selectedItemColor: Colors.red,
                currentIndex: tabProvider.currentIndex,
                onTap: (value) {
                  tabProvider.changeIndex(value);
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
