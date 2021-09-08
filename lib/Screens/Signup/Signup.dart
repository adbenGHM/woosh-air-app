import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Signup_controller.dart';

class Signup extends StatelessWidget {
  Signup({
    Key? key,
  }) : super(key: key);

  final SignupController controller = Get.put(SignupController());

  Widget _buildManualForm(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText.primary(
            "Signup",
          ),
          CustomText(
            "with email",
            color: Color(0xffa1a1a1),
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 20),
          InputFormCustom(
            hintText: "Name",
            inputAction: TextInputAction.next,
            controller: controller.nameController,
          ),
          SizedBox(height: 10),
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
                        "Already have an account?",
                        fontWeight: FontWeight.w400,
                      ),
                      InkWell(
                        onTap: ()=>Get.offNamed('/login'),
                        child: CustomText(
                          "Login here",
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
                    controller.signup();
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

  Widget _buildSignupForm(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: Get.height * 0.1072),
        _buildManualForm(context),
      ],
    );
  }

  Widget _buildSignup(BuildContext context) {
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
                          color: signup_HeaderBG,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          mainLogo,
                          width:
                              100 * scaleScreen < 120 ? 100 * scaleScreen : 120,
                        ),
                      ),
                      _buildSignupForm(context),
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
        child: _buildSignup(context),
      ),
    );
  }
}
