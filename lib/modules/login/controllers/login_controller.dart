import 'package:eisteintaste/global/constant/route.dart';
import 'package:eisteintaste/global/widgets/show_snack_bar.dart';
import 'package:eisteintaste/modules/login/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eisteintaste/models/user.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepo = Get.find<LoginRepository>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var user = User().obs;

  Future<void> login() async {
    if(formKey.currentState!.validate()){
      isLoading.value = true;
      final auth = await loginRepo.loginUser(emailController.text, passwordController.text);
      if(auth.error == null){
        Get.offAndToNamed(Routes.homeRoute);
        showMessageSnackbarBottom("The user has successfully logged in.");
      }  
      else{
        showMessageTop("Alert", "${auth.error}");
      } 
    }
  }
}
