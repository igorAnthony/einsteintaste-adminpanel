import 'package:eisteintaste/global/constant/colors.dart';
import 'package:eisteintaste/global/constant/decoration.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrEditCategoryView extends GetView<CategoryController>{
  final String pageName;
  final int? categoryId;

  const AddOrEditCategoryView({super.key, required this.pageName, this.categoryId});

  @override
  Widget build(BuildContext context) {
    if(categoryId != null){
      controller.updateTheValues(categoryId!);
    }else{
      controller.reset();
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: bigText("$pageName"),),
              Container(),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.95,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          width: Dimensions.screenWidth/4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: Dimensions.width20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildMaterialDecoration(
                          borderRadius: Dimensions.border10,
                          TextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                            decoration: kInputDecoration('Category name', Icons.fastfood, iconColor: AppColors.iconColor1),
                          ),
                        ),                        
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: Dimensions.height30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    kTextButton(fontSize: Dimensions.font14, borderRadius: Dimensions.height5, categoryId != null ? "Update" : "Add category", (){
                      if(categoryId != null){
                        controller.updateCategory(categoryId!);
                      }else{
                        controller.addCategory();
                      }
                      controller.currentIndex.value = 0;
                    }, backgroundColor: AppColors.iconColor1),
                    kTextButton(fontSize: Dimensions.font14, borderRadius: Dimensions.height5, "Cancel", (){
                      controller.currentIndex.value = 0;
                    }, backgroundColor: AppColors.iconColor1),
                  ],
                )
              ),
              SizedBox(height: Dimensions.height30),
              controller.isUpdated ? Container(
                child: GestureDetector(
                  onTap: () {
                    controller.currentIndex.value = 0;
                    controller.deleteCategory(categoryId!);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Color.fromARGB(255, 105, 15, 15)),
                      SizedBox(width: Dimensions.width5),
                      bigText("Remover item", color: Color.fromARGB(255, 105, 15, 15),),
                    ],
                  ),
                ),
              ) : Container(),
          ]),
        ),
    ]);
  }
}
