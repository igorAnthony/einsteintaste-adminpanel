import 'package:eisteintaste/global/constant/colors.dart';
import 'package:eisteintaste/global/constant/decoration.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/constant/route.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:eisteintaste/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                height: Dimensions.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.height30),
                      child: 
                      Center(
                        child: 
                          Image.asset(
                            'assets/images/logo6.png',
                            height: 200
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width5),
                      child: bigText("Hello", size: Dimensions.font60, weight: FontWeight.bold)
                    ),
                    smallText("Sign into your account", size: Dimensions.font18, color: Colors.white.withOpacity(0.3)),
                    SizedBox(height: Dimensions.height45),
                    Container(
                      width: Dimensions.containerSizeLogin,
                      child: buildMaterialDecoration(                
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: controller.emailController,
                          // validator: (val) =>
                          //     val!.isEmpty ? 'Invalid email address' : null,
                          decoration: kInputDecoration('Email', Icons.alternate_email, iconColor: AppColors.iconColor3),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Container(
                      width: Dimensions.containerSizeLogin,
                      child: buildMaterialDecoration(
                        TextFormField(
                          controller: controller.passwordController,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          // validator: (val) =>
                          //     val!.length < 6 ? 'Invalid password address' : null,
                          decoration: kInputDecoration('Password', Icons.password, iconColor: AppColors.iconColor3),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height30),
                    controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : Center(
                          child: kTextButton(
                            fontSize: Dimensions.font20,
                            paddingVertical: Dimensions.height20, 
                            paddingHorizontal: Dimensions.width30,
                            borderRadius: Dimensions.radius5,
                            backgroundColor: AppColors.iconColor3,
                            'Sign in', () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.login();
                              }
                            }
                          ),
                        ),
                    SizedBox(height: Dimensions.height20),
                    kLoginOrRegisterHint("Not registered yet? ", 'Register here',
                        () {
                      Get.offAndToNamed(Routes.registerRoute);
                    }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
