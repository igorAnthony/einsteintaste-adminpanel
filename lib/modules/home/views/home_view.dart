import 'package:eisteintaste/global/constant/decoration.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/icon_and_text.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/modules/home/controller/admin_controller.dart';
import 'package:eisteintaste/modules/category/views/category_view.dart';
import 'package:eisteintaste/modules/order/views/orders_view.dart';
import 'package:eisteintaste/modules/overview/view/overview_view.dart';
import 'package:eisteintaste/modules/product/controllers/product_controller.dart';
import 'package:eisteintaste/modules/product/views/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewPageState();
}

class _DashboardViewPageState extends State<DashboardView> {
  int currentIndex = 0;
  final List<Widget> _children = [
    OverviewView(),
    ProductView(),
    CategoryView(),
    OrdersView(),
  ];
  final List<Widget> _childrenMenu = [
    iconAndTextWidget('Overview', Icons.bar_chart_rounded, Colors.black, textColor: Colors.black),
    iconAndTextWidget('Product', Icons.flatware , Colors.black, textColor: Colors.black),
    iconAndTextWidget('Category', Icons.art_track, Colors.black, textColor: Colors.black),
    iconAndTextWidget('Orders', Icons.description, Colors.black, textColor: Colors.black),
  ];
  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.find<AdminController>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.6),
                )
              ),
            child: Row(
              children: [
                bigText('AdminPanel')
              ],
            )
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height5, horizontal: Dimensions.width5),
                  width: Dimensions.tabSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _childrenMenu.length,
                        itemBuilder:(context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            child: GestureDetector(
                              onTap: () {
                                adminController.currentIndex.value = index;
                                Get.find<ProductController>().currentIndex.value = 0;
                              },
                              child: buildMaterialDecoration(_childrenMenu[index])),
                          );
                      }),
                    ],
                  ),
                ),
                Obx(() => _children[adminController.currentIndex.value])
              ],
            ),
          ),
        ],
      ),
    );
  }
}