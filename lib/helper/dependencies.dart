import 'package:eisteintaste/modules/home/binding/admin_binding.dart';
import 'package:eisteintaste/modules/category/bindings/category_binding.dart';
import 'package:eisteintaste/modules/login/bindings/login_binding.dart';
import 'package:eisteintaste/modules/order/bindings/orders_bindings.dart';
import 'package:eisteintaste/modules/overview/binding/overview_binding.dart';
import 'package:eisteintaste/modules/product/bindings/product_binding.dart';
import 'package:eisteintaste/modules/register/bindings/register_binding.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies(){
    LoginBinding().dependencies();
    RegisterBinding().dependencies();
    CategoryBinding().dependencies();
    OrdersBinding().dependencies();
    OverviewBinding().dependencies();
    AdminBinding().dependencies();
    ProductBinding().dependencies();
  }

}
