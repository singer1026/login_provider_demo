import 'package:flutter/material.dart';
import '../../event_bus/events.dart';

class HomeProvider with ChangeNotifier {
  var pageIndex = 1;
  List<String> homeDataList = <String>[];
  bool _isLoading = false;
  bool _hasMoreData = true;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  ScrollController scrollController = ScrollController();


  HomeProvider(){
    eventBus.on<LoginSuccessEvent>().listen((event) {
      loadData();
    },);
    eventBus.on<LogoutEvent>().listen((event) {
      homeDataList.clear();
      pageIndex = 1;
      _isLoading = false;
      _hasMoreData = true;
    },);
  }

  Future<void> loadData() async {
    if (_isLoading) return;
    if (_hasMoreData == false) return;
    if (pageIndex > 3) {
      //加载3页 超过3页则没有更多数据了
      _isLoading = false;
      _hasMoreData = false;
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    List<String> list = List.generate(
      20,
      (index) {
        return "PageIndex:$pageIndex index:$index";
      },
    );
    pageIndex++;
    homeDataList.addAll(list);
    _isLoading = false;
    _hasMoreData = true;
    notifyListeners();
  }
}
