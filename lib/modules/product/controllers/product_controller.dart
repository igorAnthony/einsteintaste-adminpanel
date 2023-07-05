import 'package:eisteintaste/global/widgets/show_snack_bar.dart';
import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/products_model.dart';
import 'package:eisteintaste/modules/category/controllers/category_controller.dart';
import 'package:eisteintaste/modules/product/repository/product_repository.dart';
import 'package:eisteintaste/modules/product/views/add_or_edit_product.dart';
import 'package:eisteintaste/modules/product/views/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var currentIndex = 0.obs;
  ProductRepository productRepo = Get.find<ProductRepository>();
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  
  List<dynamic> _productList = [];
  List<dynamic> _catList = [];

  List<dynamic> get productList => _productList;
  List<dynamic> get catList => _catList;

  RxBool _isLoaded = false.obs;
  RxBool get isLoaded => _isLoaded;
  RxBool isVisible = false.obs;
  RxBool isChecked = true.obs;
  bool isUpdated = false;
  RxInt selectedCategory = (1).obs;

  final List<Widget> children = [
    ProductListView(),
    AddOrEditProductView(pageName: 'Create new item'),
  ];

  @override
  void onInit() {
    _getProductList();
    super.onInit();
  }
  
  void _getCategoryList() {
    CategoryController categoryController = Get.find<CategoryController>();
    _catList = categoryController.categoryList;
  }

  Future<void> _getProductList() async {
    ApiResponse response = await productRepo.getProductList();
    _getCategoryList();
    _productList.addAll(response.data as List<dynamic>);
    update();
    _isLoaded.value = true;
  }
  Future<void> changeTheVisibility(int index) async {
    ApiResponse response =
        await productRepo.changeVisibility(_productList[index].id);
    if (response.error == null) {
      showMessageSnackbarBottom(_productList[index].visibility == "visible"
              ? "Product is hidden!"
              : "Product is visible!");
      _productList[index].visibility = _productList[index].visibility == "1" ? "0" : "1";
      update();
    }
  }

  Future<void> addItem() async {
    Products newProduct = new Products(name: nameController.text, description: descriptionController.text, price: double.parse(priceController.text), visibility: isChecked.value ? '1' : '0', id_category: selectedCategory.value);
    ApiResponse response = await productRepo.createProduct(newProduct);
    if(response.error == null){
      Products createdProduct = response.data as Products;
      _productList.add(createdProduct);
      update();
      showMessageSnackbarBottom("Item has been added");
    }else{
      showMessageTop("Alert", "There was a problem trying to register: " + response.error!);
    }   
  }
  Future<void> editItem(int index) async {
    _productList[index].name = nameController.text;
    _productList[index].description = descriptionController.text;
    _productList[index].price = double.parse(priceController.text);
    _productList[index].visibility = isChecked.value ? "1" : "0";
    _productList[index].id_category = selectedCategory.value;
    //Products product = new Products(name: nameController.text, description: descriptionController.text, price: priceController.text);
    ApiResponse response = await productRepo.editProduct(_productList[index]);
    if(response.error == null){
      update();
      showMessageSnackbarBottom("Item has been updated");
    }else{
      showMessageTop("Alert", "There was a problem trying to update: " + response.error!);
    }
    
  }
  void deleteItem(int index) async {
    if(_productList[index].id != null){
      ApiResponse response = await productRepo.deleteProduct(_productList[index].id);
      if(response.error == null){
        currentIndex.value = 0;
        _productList.removeAt(index);
        showMessageSnackbarBottom("Item has been deleted");
        update();
      }else{
        showMessageTop("Alert", "There was a problem trying to delete: " + response.error!);
      }
    }    
  }
  void reset() {
    nameController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    isChecked.value = true;
    isUpdated = false;
    selectedCategory.value = 1;
  }
  void updateTheValues(int index){
    Products product = _productList[index];
    nameController.text = product.name!;
    descriptionController.text = product.description!;
    priceController.text = product.price!.toString();
    isUpdated = true;
    isChecked.value = product.visibility == "0" ? false : true;
    selectedCategory.value = product.id_category!;
  }
}
