
import 'package:eisteintaste/modules/overview/controller/overview_controller.dart';
import 'package:get/get.dart';

class OverviewBinding implements Bindings {
  
  @override
  void dependencies(){
    Get.lazyPut<OverviewController>(()=>OverviewController());
  }
}