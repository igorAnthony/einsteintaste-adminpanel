import 'package:eisteintaste/global/constant/colors.dart';
import 'package:eisteintaste/global/constant/decoration.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:eisteintaste/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrEditProductView extends StatefulWidget{
  final String pageName;
  final int? productId;

  const AddOrEditProductView({super.key, required this.pageName, this.productId});
  
  @override
  State<AddOrEditProductView> createState() => _AddOrEditProductViewState();
}

class _AddOrEditProductViewState extends State<AddOrEditProductView> {

  @override
  Widget build(BuildContext context) {

    CategoryController categoryController = Get.find<CategoryController>();
    ProductController controller = Get.find<ProductController>();
    int? productId = widget.productId;
    String pageName = widget.pageName;
    
    if(productId != null){
      controller.updateTheValues(productId);
    }else{
      controller.reset();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: Dimensions.profileImgSize,
                    width: Dimensions.profileImgSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.iconColor1,
                    ),
                    child: Icon(Icons.person, size: 50,color: Colors.white,),
                  ),
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
                            decoration: kInputDecoration('Food name', Icons.fastfood, iconColor: AppColors.iconColor1),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            Container(
                              width: Dimensions.width125,
                              child: buildMaterialDecoration(
                                borderRadius: Dimensions.border10,
                                TextFormField(
                                  controller: controller.priceController,
                                  keyboardType: TextInputType.name,
                                  validator: (val) => val!.isEmpty ? 'Invalid price' : null,
                                  decoration: kInputDecoration('Price', Icons.money, iconColor: AppColors.iconColor1),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10),
                            Obx(() => Container(
                              width: 250,
                              margin: EdgeInsets.only(left: Dimensions.width10),
                              child: DropdownButtonFormField<int>(
                                iconEnabledColor: AppColors.iconColor1,
                                value: controller.selectedCategory.value,
                                onChanged: (value) {
                                  controller.selectedCategory.value = value!;
                                },
                                items: categoryController.categoryList.map((category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id,
                                    child: Container(margin: EdgeInsets.only(left: Dimensions.height5), child: bigText(category.name)),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Category',
                                  labelStyle: TextStyle(color: AppColors.iconColor1, fontSize: Dimensions.font16),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.2)), 
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.iconColor1), 
                                  ),
                                ),
                                dropdownColor: Colors.white, 
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                        buildMaterialDecoration(
                          borderRadius: Dimensions.border10,
                          TextFormField(
                            controller: controller.descriptionController,
                            keyboardType: TextInputType.multiline,
                            enableSuggestions: true,
                            autocorrect: true,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            maxLength: 1000,
                            validator: (val) => val!.isEmpty ? 'Invalid description' : null,
                            decoration: kInputDecoration('Description', Icons.comment, iconColor: AppColors.iconColor1),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10,),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.isChecked.value, 
                                  onChanged: (bool? value) {
                                    controller.isChecked.value = !controller.isChecked.value;
                                  },
                                )
                              ),
                              Container(
                                child: smallText("Do you want the item to be displayed on the sales screen?", size: Dimensions.font14, color: Colors.black)
                              ),
                            ],
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
                    kTextButton(fontSize: Dimensions.font14, borderRadius: Dimensions.height5, "Add product", (){
                      if(productId != null){
                        controller.editItem(productId);
                      }else{
                        controller.addItem();
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
                    controller.deleteItem(productId!);
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
              ) : Container()
          ]),
        ),
    ]);
  }
}
