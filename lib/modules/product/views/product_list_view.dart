import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/icon_and_text.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/models/category_model.dart';
import 'package:eisteintaste/models/products_model.dart';
import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:eisteintaste/modules/product/controllers/product_controller.dart';
import 'package:eisteintaste/modules/product/views/add_or_edit_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find<ProductController>();
    CategoryController categoryController = Get.find<CategoryController>();
    print(categoryController.categoryList.length);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: bigText("Items list"),),
              GestureDetector(
                onTap: () {
                  productController.children[1] = AddOrEditProductView(pageName: 'Create new item');
                  productController.currentIndex.value = 1;
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
            height: MediaQuery.of(context).size.height * 0.9,
            child: GetBuilder<ProductController>(
              init: productController,
              builder: (controller) => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    Products product = controller.productList[index];          
                    String productName = "";
                    Category category = categoryController.getCategoryById(product.id_category!);
                    String categoryName = "";
                    if(category.name != null){
                      categoryName = category.name!;
                    }
                    
                    productName = product.name!;
                    
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.height10, horizontal: Dimensions.width10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){ 
                              productController.children[1] = AddOrEditProductView(pageName: "Update $productName", productId: index);
                              controller.currentIndex.value = 1;
                            },
                            child: Container(
                              height: Dimensions.productImgSize*1.35,
                              width: Dimensions.productImgSize*1.35,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.radius10),
                                  color: Colors.orange,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/food3.jpg"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.productContainer,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius5),
                                    bottomRight: Radius.circular(Dimensions.radius5),
                                  ),
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
                                          bigText("${productName}"),
                                          smallText("${categoryName}", size:12),
                                        ],
                                      ),
                                    ),
                                    product.visibility == "1"
                                        ? GestureDetector(
                                          onTap:() {
                                            controller.changeTheVisibility(index);
                                          },
                                          child: Container(
                                            margin:EdgeInsets.only(right:Dimensions.width10),
                                            child: Icon(Icons.visibility)
                                          ))
                                        : GestureDetector(
                                          onTap:() {
                                            controller.changeTheVisibility(index);
                                          },
                                          child: Container(
                                            margin:EdgeInsets.only(right:Dimensions.width10),
                                            child: Icon(Icons.visibility_off_outlined)
                                          )),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
            ),
          ) : Container(height: MediaQuery.of(context).size.height * 0.9, child: Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}