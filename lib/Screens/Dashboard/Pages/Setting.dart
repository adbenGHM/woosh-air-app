import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Filter_controller.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  final FilterController _controller = Get.put(FilterController());

  Widget _buildFilter() {
    return Obx(
      () => Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            alignment: Alignment.centerLeft,
            child: CustomText.primary(
              "Filters",
            ),
          ),
          SizedBox(height: 5),
          ..._controller.hubs.map(
            (hub) {
              String name = hub["vanity_name"];
              return CustomTile(
                name,
                icon: Icons.delete_outline_outlined,
                onTap: () {
                  _controller.deleteFilter(hub["_id"], name);
                },
                margin: EdgeInsets.symmetric(vertical: 5),
                icon2: Icons.mode_edit_outline_outlined,
                onTap2: () =>  _controller.onChangeFilterName(hub["_id"]),
              );
            },
          ),
          _controller.hubs.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomText(
                    "No filter added",
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.getHubs,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: CustomText.primary(
                    "Setting",
                  ),
                ),
                SizedBox(height: 10),
                CustomTile(
                  "Add new filter",
                  icon: Icons.add,
                  onTap: _controller.onScan,
                ),
                SizedBox(height: 10),
                Obx(
                  () => CustomTile(
                    _controller.pincode.value.isEmpty
                        ? "Add Zipcode"
                        : _controller.pincode.value,
                    icon: Icons.location_on_outlined,
                    onTap: _controller.addPincode,
                  ),
                ),
                SizedBox(height: 10),
                _buildFilter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
