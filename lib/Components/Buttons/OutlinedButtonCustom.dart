import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color? splashColor;
  final void Function()? onTap;

  const OutlinedButtonCustom({
    Key? key,
    required this.child,
    this.borderColor = primaryColor,
    this.splashColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        primary: splashColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
