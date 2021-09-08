import 'package:flutter/material.dart';

class FlatButtonCustom extends StatelessWidget {
  final Widget child;
  final Color? splashColor;
  final Color? backgroundColor;
  final Function()? onTap;

  const FlatButtonCustom({
    Key? key,
    required this.child,
    this.splashColor,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        primary: splashColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
