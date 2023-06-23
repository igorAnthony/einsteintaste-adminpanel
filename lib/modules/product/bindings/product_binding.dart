
import 'package:eisteintaste/modules/product/controllers/product_controller.dart';
import 'package:eisteintaste/modules/product/provider/product_provider.dart';
import 'package:eisteintaste/modules/product/repository/product_repository.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings {
  
  @override
  void dependencies(){
    Get.lazyPut<ProductProvider>(()=>ProductProvider());
    Get.lazyPut<ProductRepository>(()=>ProductRepository(productProvider: Get.find<ProductProvider>()));
    Get.lazyPut<ProductController>(()=>ProductController());
  }
}