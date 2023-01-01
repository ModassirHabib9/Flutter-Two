import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyCustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType? kry;
  final double? width;
  final double? hight;
  final int? maxLines;
  // final Function? onChange;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  // final Function onTap;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  // final Color borderColor;
  final bool? obscureText;
  final BorderRadius? borderRadius;
  // final InputDecoration decoration;
  // final Function(String) validator;

  // final MaskFilter maskFilter;
  MyCustomTextField({
    @override required this.hint,
    this.width,
    // this.onChange,
    this.kry,
    // required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    // required this.onTap,
    this.controller,
    this.hight,
    this.maxLines,
    this.textAlign,
    this.contentPadding,
    this.validator,
    this.obscureText,
    this.borderRadius,
    // required this.borderColor,
    /*required this.decoration*/
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      child: TextFormField(
        // onChanged: onChange!,
        controller: controller,
        maxLines: maxLines ?? 1,
        keyboardType: kry,
        textAlign: textAlign ?? TextAlign.start,
        validator: validator,

        decoration: InputDecoration(
          contentPadding: contentPadding ?? EdgeInsets.fromLTRB(12, 10, 0, 10),
          hintText: hint,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color(0xFFF0F0F0),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorBorder: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(10.r)),
              borderSide: BorderSide(color: Color(0xFFF0F0F0), width: 2.w)),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(10.r)),
              borderSide: BorderSide(color: Color(0xFFF0F0F0), width: 2.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(10.r)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(240, 240, 240, 100), width: 2.w)),
        ),
        // inputFormatters: [phoneFormatter],
      ),
    );
  }
}
