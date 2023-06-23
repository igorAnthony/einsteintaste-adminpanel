import 'package:eisteintaste/global/constant/route.dart';
import 'package:eisteintaste/global/widgets/show_snack_bar.dart';
import 'package:eisteintaste/modules/register/repository/register_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eisteintaste/models/user.dart';

class RegisterController extends GetxController {
  final RegisterRepository registerRepo = Get.find<RegisterRepository>();
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var user = User().obs;

  Future<void> register() async {
    if(formKey2.currentState!.validate()){
      var auth = await registerRepo.registerUser(nameController.text, emailController.text, passwordController.text);
      if(auth.error == null){
        isLoading.value = true;
        Get.offAndToNamed(Routes.loginRoute);
        showMessageSnackbarBottom('User Registered Successfully');
      }else{
        showMessageTop("Alert", "${auth.error}");
      }      
    }
  }
}
