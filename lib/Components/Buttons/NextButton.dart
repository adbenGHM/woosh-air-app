import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NextButton extends StatelessWidget {
  final Function()? onTap;
  final bool isLoading;

  const NextButton({
    Key? key,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Material(
        color: primaryColor,
        child: InkWell(
          onTap: isLoading ? () {} : onTap,
          child: Container(
            padding: EdgeInsets.all(15),
            child: !isLoading
                ? Image.asset(
                    "assets/icons/arrowWhite.png",
                    width: 19,
                  )
                : SpinKitRing(
                    color: Colors.white,
                    size: 19.0,
                    lineWidth: 2,
                  ),
          ),
        ),
      ),
    );
  }
}
