import 'package:eisteintaste/modules/home/binding/admin_binding.dart';
import 'package:eisteintaste/modules/home/views/home_view.dart';
import 'package:eisteintaste/modules/product/views/add_or_edit_product.dart';
import 'package:eisteintaste/modules/login/bindings/login_binding.dart';
import 'package:eisteintaste/modules/login/views/login_view.dart';
import 'package:eisteintaste/modules/order/bindings/orders_bindings.dart';
import 'package:eisteintaste/modules/order/views/orders_view.dart';
import 'package:eisteintaste/modules/register/bindings/register_binding.dart';
import 'package:eisteintaste/modules/register/views/register_view.dart';
import 'package:eisteintaste/modules/welcome/welcome_view.dart';
import 'package:get/get.dart';

class Routes{
  static const welcomeRoute = '/welcome';
  static const loginRoute = '/login';
  static const registerRoute = '/register';
  static const homeRoute = '/home';
  static const foodPageRoute = '/food';
  static const foodBodyRoute = '/foodbody';
  static const ordersRoute = '/orders';
  static const cartRoute = '/cart';
  static const profileRoute = '/profile';
  static const loggedRoute = '/logged';
  static const popularFoodDetailsRoute = '/popular';
  static const recommendedFoodDetailsRoute = '/recommended';
  static const createProductRoute = '/admin/create';
  static const adminRoute = '/admin';


  static String getWelcomeView()=>'$welcomeRoute';
  static String getAdminView()=>'$adminRoute';
  static String getCreateOrEditProductView(int? productId, String pageName){
    if(productId != null){
      return '$createProductRoute?productId=$productId&pageName=$pageName';
    }else{
      return '$createProductRoute?pageName=$pageName';
    }
    
  }
  static List<GetPage> getPages = [
  
  GetPage(
    name: welcomeRoute,
    page: () => WelcomeView(),
  ),
  GetPage(
    name: loginRoute,
    page: () => LoginView(),
    binding: LoginBinding(),
    transition: Transition.rightToLeft
  ),
  GetPage(
    name: registerRoute,
    page: () => RegisterView(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: ordersRoute,
    page: () => OrdersView(),
    binding: OrdersBinding(),
  ),
  GetPage(
    name: createProductRoute,
    page: () {
      var productId = Get.parameters['productId'];
      var pageName = Get.parameters['pageName'] ?? "";

      if(productId == null){
        return AddOrEditProductView(pageName: pageName);
      }else{
        return AddOrEditProductView(pageName: pageName, productId: int.parse(productId));
      } 
    },
    binding: AdminBinding(),
    transition: Transition.fadeIn
  ),
  GetPage(
    name: homeRoute,
    page: (){
      return DashboardView();
    }
  )
];
}
