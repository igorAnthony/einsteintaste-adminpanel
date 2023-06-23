import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:eisteintaste/modules/category/provider/category_provider.dart';
import 'package:eisteintaste/modules/category/repository/category_repository.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies(){
    Get.lazyPut<CategoryProvider>(()=>CategoryProvider());
    Get.lazyPut<CategoryRepository>(()=>CategoryRepository(categoryProvider: Get.find<CategoryProvider>()));
    Get.lazyPut<CategoryController>(()=>CategoryController());
  }
}