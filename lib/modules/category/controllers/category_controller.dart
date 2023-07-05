
import 'package:eisteintaste/global/widgets/show_snack_bar.dart';
import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/category_model.dart';
import 'package:eisteintaste/modules/category/repository/category_repository.dart';
import 'package:eisteintaste/modules/category/views/add_or_edit_category.dart';
import 'package:eisteintaste/modules/category/views/category_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  
  final List<dynamic> _categoryList = [];

  List<dynamic> get categoryList => _categoryList;

  final RxBool _isLoaded = false.obs;
  RxBool get isLoaded => _isLoaded;
  bool isUpdated = false;
  RxInt currentIndex = (0).obs;

  final TextEditingController nameController = TextEditingController();
  
  final List<Widget> children = [
    CategoryListView(),
    AddOrEditCategoryView(pageName: 'Create new item'),
  ];
  @override
  void onInit() {
    _getCategoryList();
    super.onInit();
  }


  Future<void> _getCategoryList() async {
    ApiResponse response = await _categoryRepository.getCategoryList();
    
    if(response.error == null){
      _categoryList.addAll(response.data as List<dynamic>);
      update();
      _isLoaded.value = true;
    }
    
  }
  Category getCategoryById(int categoryId)  {
    Category cat = Category();
    cat = _categoryList.firstWhere((category) => category.id == categoryId, orElse: () => cat);
    return cat;
  }

  Future<void> addCategory() async {
    ApiResponse response = await _categoryRepository.createCategory(nameController.text);
    if(response.error == null){
      Category cat = response.data as Category;
      _categoryList.add(cat);
      showMessageSnackbarBottom("Category has been added");
      update();
    }else{
      showMessageTop("Alert", "There was a problem trying to add:  ${response.error!}");
    }   
  }
  Future<void> updateCategory(int index) async{
    _categoryList[index].name = nameController.text;
    ApiResponse response = await _categoryRepository.updateCategory(_categoryList[index].id, nameController.text);
     if(response.error == null){
      update();
      showMessageSnackbarBottom("Category has been updated");
    }else{
      showMessageTop("Alert", "There was a problem trying to update: ${response.error!}");
    }
  }
  Future<void> deleteCategory(int index) async{
    if(_categoryList[index].id != null){
      ApiResponse response = await _categoryRepository.deleteCategory(_categoryList[index].id);
      if(response.error == null){
        _categoryList.removeAt(index);
        showMessageSnackbarBottom("Category has been deleted");
        update();
      }else{
        showMessageTop("Alert", "There was a problem trying to delete: ${response.error!}");
      }
    }
  }

   void reset() {
    nameController.text = "";
    isUpdated = false;
  }
  void updateTheValues(int index){
    Category cat = _categoryList[index];
    nameController.text = cat.name!;
    isUpdated = true;
  }
}
