import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget{
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    return Expanded(
      child: SingleChildScrollView(
          child:Obx(() => categoryController.children[categoryController.currentIndex.value]),
      ),
    );
  }
  
}
