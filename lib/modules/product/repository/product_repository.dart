import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/products_model.dart';
import 'package:eisteintaste/modules/product/provider/product_provider.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxService {
  final ProductProvider productProvider;

  ProductRepository({required this.productProvider});

  Future<ApiResponse> changeVisibility(int product_id) async {
    final response = await productProvider.changeVisibility(product_id);
    return response;
  }
  Future<ApiResponse> getProductList() async {
    final response = await productProvider.getProductList();
    return response;
  }
  Future<ApiResponse> createProduct(Products product) async {
    final response = await productProvider.createProduct(product);
    return response;
  }
  Future<ApiResponse> editProduct(Products product) async {
    final response = await productProvider.editProduct(product);
    return response;
  }
  Future<ApiResponse> deleteProduct(int id) async {
    final response = await productProvider.deleteProduct(id);
    return response;
  }
}