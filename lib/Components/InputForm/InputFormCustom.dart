import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';

class InputFormCustom extends StatelessWidget {
  final String? hintText;
  final bool isTextHidden;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final TextInputType? keyboadType;

  const InputFormCustom({
    Key? key,
    this.hintText,
    this.isTextHidden = false,
    this.inputAction,
    this.controller,
    this.keyboadType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboadType,
      controller: controller,
      textInputAction: inputAction,
      style: TextStyle(
        fontSize: secondaryFontSize,
      ),
      obscureText: isTextHidden,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 22,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffB2B2B2),
          fontSize: secondaryFontSize,
        ),
        isCollapsed: true,
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(49),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(49),
        ),
        errorBorder: new OutlineInputBorder(),
        disabledBorder: new OutlineInputBorder(),
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(49),
        ),
      ),
    );
  }
}
