import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';
import 'package:get/get.dart';
// import 'package:woosh/DebugTool/DebugTool.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expandable/expandable.dart';

class FilterCard extends StatelessWidget {
  final String title;
  final List<Map> pressure;
  FilterCard(
    this.title, {
    Key? key,
    this.pressure = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding:
          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 3.0,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            title,
            fontWeight: FontWeight.w400,
            color: Color(0xff6D6D6D),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          majorGridLines: MajorGridLines(
                            color: Colors.transparent,
                          ),
                          isVisible: false,
                        ),
                        primaryYAxis: CategoryAxis(
                          majorGridLines: MajorGridLines(
                            color: Colors.transparent,
                          ),
                        ),
                        plotAreaBorderColor: Colors.transparent,
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                          toggleSeriesVisibility: false,
                        ),
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <ChartSeries<Map, String>>[
                          LineSeries(
                            name: "Pressure",
                            dataSource: pressure,
                            xValueMapper: (Map air, _) => air["date"],
                            yValueMapper: (Map air, _) => air["data"],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     children: [
              //       CustomText(
              //         "Air quality",
              //         color: Color(0xff6D6D6D),
              //       ),
              //       SizedBox(height: 10),
              //       SizedBox(
              //         width: diameter,
              //         height: diameter,
              //         child: CircularProgressIndicator(
              //           value: 0.8,
              //           color: primaryColor,
              //           backgroundColor: Colors.grey.shade200,
              //           strokeWidth: 10,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 8),
          Divider(),
          ExpandablePanel(
            header: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "More",
              ),
            ),
            collapsed: SizedBox(),
            expanded: Column(
              children: [
                CustomText(
                  "Coming soon...",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
