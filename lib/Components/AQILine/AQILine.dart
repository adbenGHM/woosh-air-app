import 'package:flutter/material.dart';

class AQILine extends StatelessWidget {
  final String title;
  final String value;
  final String heading;
  final Color color;
  final String dateLocation;

  const AQILine({
    Key? key,
    required this.title,
    required this.value,
    required this.heading,
    required this.color,
    this.dateLocation = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        height: dateLocation.length!=0?190:170,
        margin: EdgeInsets.only(top:7, bottom:7),
        padding: EdgeInsets.only(left:10, right:10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 7),
              child: Center(
                child: Text(heading, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: dateLocation.length!=0?15:0, top: dateLocation.length!=0?5:0),
              child: Center(
                child: Text(dateLocation),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(
                    height: 20,
                    child: Text("0"),
                  ),
                ),
                Expanded(child: Container(
                    height: 20,
                    child: Text("50"),
                  ),
                ),
                Expanded(child: Container(
                    height: 20,
                    child: Text("100"),
                  ),
                ),
                Expanded(child: Container(
                    height: 20,
                    child: Text("150"),
                  ),
                ),
                Expanded(child: Container(
                    height: 20,
                    child: Text("200"),
                  ),
                ),
                Expanded(child: Container(
                    height: 20,
                    child: Text("300"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xff01FF00),
                  ),
                ),
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xffFFFF00),
                  ),
                ),
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xffFF9900),
                  ),
                ),
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xffFF0000),
                  ),
                ),
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xff8E7CC3),
                  ),
                ),
                Expanded(child: Container(
                    height: 10,
                    color: Color(0xff84210D),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  margin: EdgeInsets.only(top:10),
                  height: 50,
                  child: Center(
                    child: Text(
                      value,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    padding: EdgeInsets.only(top:10),
                    child: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ),
              ]                  
            )
          ],
        ),
      );
  }
}

class Forecast extends StatelessWidget {
  final String valueToday;
  final String valueTomorrow;
  
  final Color colorToday;
  final Color colorTomorrow;

  final String titleToday;
  final String titleTomorrow;

  const Forecast({
    Key? key,
    required this.valueToday,
    required this.colorToday,
    required this.titleToday,
    required this.valueTomorrow,
    required this.colorTomorrow,
    required this.titleTomorrow,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        height: 175,
        margin: EdgeInsets.only(top:7, bottom:7),
        padding: EdgeInsets.only(left:10, right:10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                child: Text("Outdoor Air Quality Forecast", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Today      "),
                    Center(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorToday
                            ),
                            child: Center(child: Text(valueToday)),
                          ),
                          SizedBox( width: 100, child:Text(titleToday))
                        ],
                      )
                    ),
                  ],
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Tomorrow"),
                    Center(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorTomorrow
                            ),
                            child: Center(child: Text(valueTomorrow)),
                          ),
                          SizedBox( width: 100, child:Text(titleTomorrow))
                        ],
                      )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      );
  }
}

