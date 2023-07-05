import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/orders_model.dart';
import 'package:eisteintaste/modules/login/provider/login_provider.dart';
import 'package:eisteintaste/modules/order/repository/orders_repository.dart';
import 'package:eisteintaste/modules/order/views/orders_list_view.dart';
import 'package:eisteintaste/modules/overview/controller/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersController extends GetxController {
  OrdersRepository ordersRepository = Get.find<OrdersRepository>();

  List<dynamic> _ordersList = [];
  List<dynamic> get ordersList => _ordersList;
  
  Map<int, String> _userMap = {};
  Map<int, String> get userMap => _userMap;


  Map<int, List<dynamic>> _ordersDetailsMap = {};
  Map<int, List<dynamic>> get ordersDetailsMap => _ordersDetailsMap;
  double subtotal = 0;
  RxBool isLoaded = false.obs;
  RxBool isLoadedItems = false.obs;
  
  RxInt currentIndex = 0.obs;
  final List<Widget> children = [
    OrdersListView(),
    Container(),
  ];


  @override
  void onInit(){
    getAllOrders();
    super.onInit();
  }
  // Future<void> getOrdersListById(int userId) async {
  //   ApiResponse response = await ordersRepository.getOrdersListById(userId);
  //   List<dynamic> ordersList = response.data as List<dynamic>;
  //   update();
  // }
  RxInt totalQuantOrders = 0.obs;
  RxDouble totalFaturation = 0.0.obs;

  void quantSalesCalculation() {
    totalQuantOrders.value = 0;
    totalFaturation.value = 0.0;
    for (Orders order in _ordersList) {
      totalQuantOrders.value += 1;
      totalFaturation.value += double.parse(order.totalAmount!);
    }
  }
  Future<void> getAllOrders() async {
    ApiResponse response = await ordersRepository.getAllOrders();
    if(response.error == null){
      _ordersList.addAll(response.data as List<dynamic>);
      getAllUsers();
      for (Orders order in _ordersList) {
        Get.find<OverviewController>().setDataInSalesData(DateTime.parse(order.createdAt!));
      }

      quantSalesCalculation();
      update();
      isLoaded.value = true;
    }    
  }
  Future<void> getAllUsers() async {
    ApiResponse response = await Get.find<LoginProvider>().getAllUsers();
    if(response.error == null){
      List<dynamic> _userList = []; 
      _userList.addAll(response.data as List<dynamic>);
      for (var user in _userList) {
        _userMap[user.id] = user.name;
      }
    }    
  }
  Future<void> requestDetailsOfOrders(int index) async { 
    ApiResponse response = await ordersRepository.getDetailsOfOrders(_ordersList[index].id!);
    if(response.error == null){
      List<dynamic> ordersDetailsList = [];
      ordersDetailsList.addAll(response.data as List<dynamic>);
      _ordersDetailsMap[_ordersList[index].id!] = ordersDetailsList;
      double sumSubtotal = 0;
      for (var voucher in ordersDetailsList) {
        sumSubtotal += voucher.totalPrice!; 
      }
      subtotal = sumSubtotal;
      update();
      isLoadedItems.value = true;
    }    
  }
  void resetOrdersDetailsList(){
    isLoadedItems.value = false;
    update();
  }
  String convertDateTimeToString(DateTime dateTime) {
    DateFormat format = DateFormat('dd/MM/yyyy'); // Formato desejado
    String dateString = format.format(dateTime);
    return dateString;
  }
}