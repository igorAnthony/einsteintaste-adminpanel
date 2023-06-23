import 'package:eisteintaste/modules/order/controller/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  
  @override
  Widget build(BuildContext context) {
    OrdersController ordersController = Get.find<OrdersController>();
    return Expanded(
      child: SingleChildScrollView(
          child:Obx(() => ordersController.children[ordersController.currentIndex.value]),
      ),
    );
  }
}
