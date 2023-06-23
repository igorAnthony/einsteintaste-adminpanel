import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/modules/category/provider/category_provider.dart';
import 'package:get/get.dart';


class CategoryRepository extends GetxService {
  final CategoryProvider categoryProvider;

  CategoryRepository({required this.categoryProvider});

  Future<ApiResponse> getCategoryList() async {
    final response = await categoryProvider.getCategoryList();
    return response;
  }
  Future<ApiResponse> createCategory(String nameCategory) async {
    final response = await categoryProvider.addCategory(nameCategory);
    return response;
  }
  Future<ApiResponse> updateCategory(int id, String updatedNameCategory) async {
    final response = await categoryProvider.updateCategory(id, updatedNameCategory);
    return response;
  }
  Future<ApiResponse> deleteCategory(int id) async {
    final response = await categoryProvider.deleteCategory(id);
    return response;
  }

}