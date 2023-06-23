import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/icon_and_text.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/models/category_model.dart';
import 'package:eisteintaste/modules/category/views/add_or_edit_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../category/controllers/category_controller.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: bigText("Category items list"),),
              GestureDetector(
                onTap: () {
                  categoryController.children[1] = AddOrEditCategoryView(pageName: 'Create new category');
                  categoryController.currentIndex.value = 1;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.height5, vertical: Dimensions.height3),
                  decoration: BoxDecoration(
                    color: Color(0xFF27AE60),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: iconAndTextWidget('New item', Icons.add, Colors.white, textColor: Colors.white)
                ),
              )
            ],
          ),
        ),
        Obx(
          () => categoryController.isLoaded.value ? Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: GetBuilder<CategoryController>(
              init: categoryController,
              builder: (controller) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    Category category = controller.categoryList[index];                
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.height10, horizontal: Dimensions.width10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap:() {
                                categoryController.children[1] = AddOrEditCategoryView(pageName: 'Edit category', categoryId: index);
                                categoryController.currentIndex.value = 1;
                              },
                              child: Container(
                                height: Dimensions.productContainer,
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFe8e8e8),
                                        blurRadius: Dimensions.shadowBlurRadius,
                                        offset: Offset(0, 5),
                                      ),
                                    ]),
                                child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.height10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            bigText("${category.name}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
            ),
          ) : Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ),
      ],
    );
  }
}