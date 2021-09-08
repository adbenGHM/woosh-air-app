import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Controllers/Global/Dashboard_controller.dart';
import 'package:woosh/Screens/Dashboard/Pages/Filters.dart';
import 'package:woosh/Screens/Dashboard/Pages/Profile.dart';
import 'package:woosh/Screens/Dashboard/Pages/Setting.dart';
import 'package:woosh/Screens/Dashboard/Pages/Notification.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final DashoardController _controller = Get.find<DashoardController>();

  Widget? _buildBottomNavigation() {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _controller.currentIndex.value,
        backgroundColor: secondaryColor,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.30),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _controller.onNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: "",
            tooltip: "Filter",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: .5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${_controller.notifications}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: "",
            tooltip: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "",
            tooltip: "Setting",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "",
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildScreen() {
    return Obx(() {
      if (_controller.currentIndex.value == 0)
        return new Filter();
        else if (_controller.currentIndex.value == 1) return new NotificationList();
      else if (_controller.currentIndex.value == 2) return new Setting();
      else if (_controller.currentIndex.value == 3) return new Profile();
      return SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBackgroundColor,
      body: SafeArea(
        child: _buildScreen(),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
