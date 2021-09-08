import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/WIFIScreen_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WIFI extends StatelessWidget {
  WIFI({Key? key}) : super(key: key);

  final WIFIScreenController _controller =
      Get.put(WIFIScreenController(Get.arguments));

  Widget _buildConnectWIFI(BuildContext context) {
    return Container(
      width: Get.width * 0.7,
      child: Column(
        children: <Widget>[
          CustomText.primary(
            "Connect to a network",
            color: Color(0xff5C5C5C),
          ),
          SizedBox(height: 20),
          InputFormCustom(
            hintText: "SSID",
            inputAction: TextInputAction.next,
            controller: _controller.ssid,
          ),
          SizedBox(height: 10),
          InputFormCustom(
            hintText: "Password",
            inputAction: TextInputAction.done,
            isTextHidden: true,
            controller: _controller.password,
          ),
          SizedBox(height: 15),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: _controller.wifi.isNotEmpty
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _controller.isManual.value = false;
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: CustomText(
                          'Or choose from available network',
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(height: 25),
          NextButton(
            onTap: () {
              FocusScope.of(context).unfocus();
              _controller.sendWifiToHub();
            },
            isLoading: _controller.isLoading.value,
          ),
        ],
      ),
    );
  }

  Widget _wifiItem(e) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _controller.selectWifi(e),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: CustomText(
                    e['ssid'],
                  ),
                ),
                Icon(
                  Icons.wifi,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWifiList() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.3,
      ),
      width: Get.width * 0.7,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomText.primary(
                "Connect to a network",
                color: Color(0xff5C5C5C),
              ),
              SizedBox(height: 15),
              ..._controller.wifi.map(
                (e) => _wifiItem(e),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _controller.isManual.value = true;
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: CustomText(
                        'Connect manually',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _providePassword(BuildContext context) {
    return Column(
      children: [
        CustomText.primary(
          "Provide Password",
          color: Color(0xff5C5C5C),
        ),
        SizedBox(height: 15),
        CustomText('${_controller.selectedWifi.value!['ssid']}'),
        SizedBox(height: 10),
        InputFormCustom(
          hintText: "Password",
          inputAction: TextInputAction.done,
          isTextHidden: true,
          controller: _controller.password,
        ),
        SizedBox(height: 15),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _controller.selectedWifi.value = null;
                _controller.ssid.text = "";
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: CustomText(
                  'Or connect to a different network',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        NextButton(
          onTap: () {
            FocusScope.of(context).unfocus();
            _controller.sendWifiToHub();
          },
          isLoading: _controller.isLoading.value,
        ),
      ],
    );
  }

  Widget _buildSelect(BuildContext context) {
    Widget widget = Column(
      children: <Widget>[
        CustomText.primary(
          "Scanning for wifi",
        ),
        SizedBox(height: 20),
        SpinKitRipple(
          color: primaryColor,
          size: 60.0,
        ),
      ],
    );
    if (_controller.isManual.value)
      widget = _buildConnectWIFI(context);
    else if (_controller.selectedWifi.value != null)
      widget = _providePassword(context);
    else if (_controller.wifi.isNotEmpty) widget = _buildWifiList();

    return widget;
  }

  Widget _buildScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: screenBackGradient,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: screenPaddingType1,
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Obx(
                () => Column(
                  children: <Widget>[
                    CustomBanner(
                      wrap: true,
                      banner: banner1,
                      bannerTitle: "Whoosh Hub was found !",
                      bannerText: "Let's connect it to the WIFI",
                      height: 170 * scaleScreen,
                    ),
                    SizedBox(height: scaleScreen * 50),
                    // _controller.isScanning.value
                    //     ? CustomText("Scanning for wifi...")
                    //     : _controller.selectedWifi.value == null
                    //         ? _controller.wifi.isNotEmpty
                    //             ? _buildWifiList()
                    //             : SizedBox()
                    //         : _providePassword(context),
                    // _controller.isManual.value
                    //     ? _buildConnectWIFI(context)
                    //     : SizedBox(),
                    _buildSelect(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: screenBackGradient,
        ),
        child: SafeArea(
          child: _buildScreen(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_rounded, color: Colors.white),
        onPressed: _controller.scanForWIFI,
        backgroundColor: primaryColor,
        elevation: 0.0,
        mini: true,
      ),
    );
  }
}
