import 'dart:convert';

import 'package:eisteintaste/global/constant/api_constant.dart';
import 'package:eisteintaste/global/constant/route.dart';
import 'package:eisteintaste/models/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  bool isLogged = false;
  late User _user;
  void set user(User user) => _user = user;
  User get user => _user;
  
  void logout() async {
    SharedPreferences prefs = Get.find<SharedPreferences>();
    prefs.remove('user');
    isLogged = false;
    user = User();
    update();
    Get.offNamed(Routes.welcomeRoute);
  }
  void init() async {
    SharedPreferences prefs = Get.find<SharedPreferences>();
    
    String userString = prefs.getString('user')!;
    Map<String, dynamic> jsonMap = jsonDecode(userString);

    User storageUser = User(
      id: jsonMap['id'],
      name: jsonMap['name'],
      email: jsonMap['email'],
      phoneNumber: jsonMap['phone_number'],
      token: jsonMap['token'],
    );
    _user = storageUser;
    box.write('token', Get.find<UserController>().user.token!);
    update();
    isLogged = true;
  }
}