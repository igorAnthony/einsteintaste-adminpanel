import 'dart:convert';

import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/orders_model.dart';
import 'package:eisteintaste/models/payment_voucher_model.dart';
import 'package:eisteintaste/global/constant/api_constant.dart';
import 'package:http/http.dart' as http;
class OrdersProvider{
  Future<ApiResponse> getOrdersListById(int userId) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.get(Uri.parse(ApiConstants.ordersURL+'/${userId}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['orders']
              .map((p) => Orders.fromJson(p))
              .toList();
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = ApiConstants.unauthorized;

          break;
        default:
          apiResponse.error = ApiConstants.somethingWentWrong;

          break;
      }
    } catch (e) {
      apiResponse.error = ApiConstants.serverError;
    }
    return apiResponse;
  }
  Future<ApiResponse> getAllOrders() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.get(Uri.parse(ApiConstants.ordersURL),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['orders']
              .map((p) => Orders.fromJson(p))
              .toList();
          apiResponse.data = apiResponse.data as List<dynamic>;    
          break;
        case 401:
          apiResponse.error = ApiConstants.unauthorized;

          break;
        default:
          apiResponse.error = ApiConstants.somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = ApiConstants.serverError;
    }
    return apiResponse;
  }
  Future<ApiResponse> getDetailsOfOrders(int order_id) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.get(Uri.parse('${ApiConstants.ordersItemsURL}/${order_id}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['paymentvoucher']
              .map((p) => PaymentVoucher.fromJson(p))
              .toList();
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = ApiConstants.unauthorized;

          break;
        default:
          apiResponse.error = ApiConstants.somethingWentWrong;

          break;
      }
    } catch (e) {
      apiResponse.error = ApiConstants.serverError;
    }
    return apiResponse;
  }
}