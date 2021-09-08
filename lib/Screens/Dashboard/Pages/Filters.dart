import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:woosh/Controllers/Filter_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Filter extends StatelessWidget {
  Filter({Key? key}) : super(key: key);

  final FilterController _controller = Get.put(FilterController());

  Widget _graphCard(
    String title,
    String value,
    // String date,
    {
    Color? color,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: color ?? Colors.grey,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Center(
          child: Column(
            children: [
              CustomText(
                title,
              ),
              SizedBox(height: 5),
              CustomText.primary(
                value,
                color: color,
              ),
              // SizedBox(height: 5),
              // CustomText(
              //   date,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 3,
                      width: 10,
                      color: Color.fromRGBO(75, 135, 185, 1),
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Container(
                      child: CustomText(
                        "Indoor",
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Container(
                      height: 3,
                      width: 10,
                      color: Color.fromRGBO(192, 108, 132, 1),
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Container(
                      child: CustomText(
                        "Outdoor",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(
                  color: Colors.transparent,
                ),
                minorGridLines: MinorGridLines(
                  color: Colors.transparent,
                ),
              ),
              // legend: Legend(
              //   isVisible: true,
              //   position: LegendPosition.top,
              //   borderWidth: 4,
              //   toggleSeriesVisibility: true,
              // ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Map, String>>[
                SplineSeries(
                  name: "Indoor",
                  dataSource: _controller.indoorAirQuality.value,
                  xValueMapper: (Map air, _) => air["date"],
                  yValueMapper: (Map air, _) => air["value"],
                ),
                SplineSeries(
                  name: "Outdoor",
                  dataSource: _controller.outdoorAirQuality.value,
                  xValueMapper: (Map air, _) => air["date"],
                  yValueMapper: (Map air, _) => air["value"],
                ),
              ],
            ),
            _controller.indoorAirQuality.value.isNotEmpty
                ? AQILine(
                    title: _controller.getColor(
                      _controller.indoorAirQuality.value.last["value"]
                          .toDouble(),
                    )?[1],
                    value: _controller.indoorAirQuality.value.last["value"]
                        .toString(),
                    heading: "Current Indoor Air Quality",
                    color: _controller.getColor(
                      _controller.indoorAirQuality.value.last["value"]
                          .toDouble(),
                    )?[0],
                  )
                : SizedBox(),
            _controller.today.value != -1.0
                ? AQILine(
                    title: _controller.getColor(_controller.today.value)?[1],
                    value: _controller.today.value.toString(),
                    heading: "Current Outdoor Air Quality",
                    color: _controller.getColor(_controller.today.value)?[0],
                    dateLocation: _controller.todayDateLocation.value,
                  )
                : SizedBox(),
            _controller.today.value != -1.0 &&
                    _controller.tomorrow.value != -1.0
                ? Forecast(
                    valueToday: _controller.today.value.toString(),
                    colorToday:
                        _controller.getColor(_controller.today.value)?[0],
                    titleToday:
                        _controller.getColor(_controller.today.value)?[1],
                    valueTomorrow: _controller.tomorrow.value.toString(),
                    colorTomorrow:
                        _controller.getColor(_controller.tomorrow.value)?[0],
                    titleTomorrow:
                        _controller.getColor(_controller.tomorrow.value)?[1],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return Obx(
      () => Column(
        children: <Widget>[
          ..._controller.hubs.map(
            (hub) => FilterCard(
              hub["vanity_name"],
              pressure: _controller.getPressure(hub["device_id"]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.initilize,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
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
                    width: 100 * scaleScreen < 120 ? 100 * scaleScreen : 120,
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                  () => !_controller.isHubOnline.value
                      ? Material(
                          borderRadius: BorderRadius.circular(2.5),
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: _controller.handleConfigure,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.red.shade200.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              child: CustomText(
                                  "Your Hub has gone offine please click here to reconfigure",
                                  wrap: true),
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
                _buildChart(),
                _buildFilter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
