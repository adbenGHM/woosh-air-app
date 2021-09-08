import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
import 'dart:io' show Platform;
import 'package:woosh/Controllers/Login_controller.dart';

class Login extends StatelessWidget {
  Login({
    Key? key,
  }) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  Widget _buildSocialButton(
    String logo, {
    Color? splashColor,
    Function()? onTap,
    Color backgroundColor = const Color(0xfff5f5f5),
    Color? iconColor,
  }) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              logo,
              fit: BoxFit.contain,
              height: 38,
              width: 38,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildSocialButton(
            login_googleLogo,
            splashColor: Color(0xffc2e5f2),
            onTap: controller.handleGoogleLogin,
          ),
          Platform.isIOS
              ? _buildSocialButton(
                  login_appleLogo,
                  splashColor: Color(0xffa1a1a1),
                  onTap: () {},
                )
              : SizedBox(),
          _buildSocialButton(
            login_facebookLogo,
            splashColor: Color(0xfff7f7f7),
            backgroundColor: Color(0xff3B5999),
            iconColor: Color(0xffffffff),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildManualForm(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText.primary(
            "Login",
          ),
          CustomText(
            "with email instead",
            color: Color(0xffa1a1a1),
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 20),
          InputFormCustom(
            hintText: "Email",
            inputAction: TextInputAction.next,
            controller: controller.emailController,
          ),
          SizedBox(height: 10),
          InputFormCustom(
            hintText: "Password",
            isTextHidden: true,
            controller: controller.passwordController,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        "Don't have an account?",
                        fontWeight: FontWeight.w400,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed('/signup'),
                        child: CustomText(
                          "Sign up here",
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => NextButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.login();
                  },
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: Get.height * 0.1067),
        _buildSocialLogin(),
        SizedBox(height: Get.height * 0.0772),
        _buildManualForm(context),
      ],
    );
  }

  Widget _buildLogin(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 35 * scaleScreen,
            ),
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 350,
                  ),
                  width: 250 * scaleScreen,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 28,
                        ),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: login_HeaderBG,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          mainLogo,
                          width:
                              100 * scaleScreen < 120 ? 100 * scaleScreen : 120,
                        ),
                      ),
                      _buildLoginForm(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: SafeArea(
        child: _buildLogin(context),
      ),
    );
  }
}
