
import 'package:eisteintaste/modules/home/controller/admin_controller.dart';
import 'package:eisteintaste/modules/home/controller/user_controller.dart';
import 'package:get/get.dart';

class AdminBinding implements Bindings {
  
  @override
  void dependencies(){
    Get.lazyPut<AdminController>(()=>AdminController());
    Get.put<UserController>(UserController(), permanent: true);
  }
}