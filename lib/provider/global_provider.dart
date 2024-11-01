import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalProvider with ChangeNotifier {
  var isLogin = false;
  User? user;

  void login() {
    user = User("1232456", "张三");
    isLogin = true;
    notifyListeners();
  }

  void logout() {
    user = null;
    isLogin = false;
    notifyListeners();
  }
}

class User {
  String id;
  String username;

  User(this.id, this.username);
}
