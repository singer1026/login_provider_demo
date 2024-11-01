import 'package:flutter/material.dart';
import 'package:login_provider_demo/pages/home/home_provider.dart';
import 'package:login_provider_demo/pages/tabbar/tab_provider.dart';
import 'package:login_provider_demo/provider/global_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    homeProvider.scrollController.addListener(
      () {
        if (homeProvider.scrollController.position.pixels >
            homeProvider.scrollController.position.maxScrollExtent - 20) {
          //当快要滚动都最底部的时候 加载更多数据
          // print(
          //     "pixels: ${homeProvider.scrollController.position.pixels}   maxScrollExtent: ${homeProvider.scrollController.position.maxScrollExtent}");
          homeProvider.loadData();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Home build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return globalProvider.isLogin
              ? _buildListView()
              : Center(
                  child: TextButton(
                      onPressed: () {
                        context.read<TabProvider>().changeIndex(1);
                      },
                      child: const Text("登录")),
                );
        },
      ),
    );
  }

  Widget _buildListView() {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        print("_buildListView Consumer builder >>>>");
        if (provider.isLoading && provider.homeDataList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.isLoading == false &&
            provider.homeDataList.isEmpty) {
          return const Center(
            child: Text("暂无数据"),
          );
        } else {
          Widget lastWidget = provider.hasMoreData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Center(
                  child: Text("没有更多数据了"),
                );
          return ListView.builder(
            controller: provider.scrollController,
            itemCount: provider.homeDataList.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.homeDataList.length) {
                return lastWidget;
              }
              return ListTile(
                title: Text(provider.homeDataList[index]),
              );
            },
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
