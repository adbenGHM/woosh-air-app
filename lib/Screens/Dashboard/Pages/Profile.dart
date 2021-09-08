import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Profile_controller.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final ProfileController _controller = Get.put(ProfileController());

  Widget _buildProfile() {
    double radius = Get.width * 0.4 > 60 ? 60 : Get.width * 0.4;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(radius * 0.5),
            decoration: BoxDecoration(
              color: secondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: radius,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 20),
          CustomText.primary(
            _controller.name.value,
            color: Colors.grey[600],
          ),
          SizedBox(height: 10),
          CustomText(
            _controller.email.value,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      children: <Widget>[
        SizedBox(height: 20),
        _buildProfile(),
        SizedBox(height: 50),
        CustomTile(
          "Logout",
          icon: Icons.logout,
          onTap: _controller.onLogout,
          margin: EdgeInsets.symmetric(vertical: 5),
        ),
        SizedBox(height: 20),
        CustomText.primary(
          "Hub controls",
        ),
        SizedBox(height: 15),
        CustomTile(
          "Change Password",
          icon: Icons.password,
          onTap: _controller.onPasswordChange,
          margin: EdgeInsets.symmetric(vertical: 5),
        ),
        CustomTile(
          "Reset",
          icon: Icons.refresh,
          onTap: _controller.onReset,
          margin: EdgeInsets.symmetric(vertical: 5),
        ),
      ],
    );
  }
}
