import 'dart:convert';
import 'package:eisteintaste/models/api_response.dart';
import 'package:eisteintaste/models/user.dart';
import 'package:eisteintaste/global/constant/api_constant.dart';
import 'package:eisteintaste/models/users.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends GetxService{
  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(ApiConstants.loginURL),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password});
      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = ApiConstants.serverError;
          break;
      }
    } catch (e) {
      apiResponse.error = ApiConstants.somethingWentWrong;
    }
    return apiResponse;
  }
  Future<ApiResponse> getAllUsers() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(Uri.parse(ApiConstants.baseURL + "/users"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
      });
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['users']
              .map((p) => Users.fromJson(p))
              .toList();
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = ApiConstants.serverError;
          break;
      }
    } catch (e) {
      apiResponse.error = ApiConstants.somethingWentWrong;
    }
    return apiResponse;
  }
}
