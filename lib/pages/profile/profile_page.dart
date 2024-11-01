import 'package:flutter/material.dart';
import 'package:login_provider_demo/main.dart';
import 'package:login_provider_demo/pages/home/home_provider.dart';
import 'package:login_provider_demo/pages/tabbar/tab_provider.dart';
import 'package:login_provider_demo/provider/global_provider.dart';
import 'package:provider/provider.dart';

import '../../event_bus/events.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("profile build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Consumer<GlobalProvider>(
          builder: (context, provider, child) {
            return provider.isLogin
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("username: ${provider.user?.username ?? ""}"),
                      TextButton(
                          onPressed: () {
                            provider.logout();
                            eventBus.fire(LogoutEvent());
                          },
                          child: const Text("退出登录"))
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("你还未登录"),
                      TextButton(
                          onPressed: () {
                            provider.login();
                            //登录成功后 回到首页 并刷新首页数据
                            context.read<TabProvider>().changeIndex(0);
                            // context.read<HomeProvider>().loadData();
                            eventBus.fire(LoginSuccessEvent());
                          },
                          child: const Text("登录"))
                    ],
                  );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
