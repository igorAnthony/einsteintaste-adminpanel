import 'package:eisteintaste/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget{
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find<ProductController>();
    return Expanded(
      child: SingleChildScrollView(
          child:Obx(() => productController.children[productController.currentIndex.value]),
      ),
    );
  }
  
}
