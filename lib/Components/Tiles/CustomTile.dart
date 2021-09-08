import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:woosh/Components/Components.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final IconData? icon2;
  final Function()? onTap;
  final Function()? onTap2;
  final EdgeInsetsGeometry margin;

  CustomTile(
    this.title, {
    Key? key,
    this.icon,
    this.icon2,
    this.onTap,
    this.onTap2,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tileColor: secondaryColor.withOpacity(0.8),
        title: CustomText(
          title,
          wrap: true,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: secondaryColor.withOpacity(0.8),
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            icon,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            icon2 != null
                ? Container(
                    margin: EdgeInsets.only(left: 5),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: secondaryColor.withOpacity(0.8),
                      child: InkWell(
                        onTap: onTap2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            icon2,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
