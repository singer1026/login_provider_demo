import 'package:flutter/material.dart';
import 'package:login_provider_demo/pages/home/home_provider.dart';
import 'package:login_provider_demo/pages/tabbar/tab_bar.dart';
import 'package:login_provider_demo/provider/global_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => GlobalProvider(),),
          // ChangeNotifierProvider(create: (context) => HomeProvider(),),
        ],
        builder: (context, child) {
          return const MyTabBar();
        },
      ),

      // home: ChangeNotifierProvider(
      //   create: (context) => GlobalProvider(),
      //   builder: (context, child) {
      //     return const MyTabBar();
      //   },
      // ),
    );
  }
}