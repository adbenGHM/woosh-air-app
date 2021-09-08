import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Notification_controller.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  NotificationList({Key? key}) : super(key: key);

  final NotificationController _controller = Get.put(NotificationController());

  Widget _buildNotifications() {
    return Obx(
      () => Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ..._controller.notifications.value.reversed.map(
              (notification) => Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Dismissible(
                  key: ValueKey(notification["_id"]),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          notification["message"],
                          textAlign: TextAlign.start,
                          wrap: true,
                        ),
                        SizedBox(height: 5),
                        CustomText(
                          DateFormat()
                              .add_yMMMd()
                              .add_Hm()
                              .format(DateTime.parse(notification["time"]))
                              .toString(),
                          textAlign: TextAlign.start,
                          fontSize: 11,
                          wrap: true,
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    color: Colors.red[200],
                  ),
                  onDismissed: (direction) =>
                      _controller.delete(notification["_id"]),
                ),
              ),
            ),
            _controller.notifications.isEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: CustomText(
                      "No notification",
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.getNotifications,
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomText.primary(
                  "Notifications",
                ),
              ),
              SizedBox(height: 20),
              _buildNotifications(),
            ],
          ),
        ],
      ),
    );
  }
}
