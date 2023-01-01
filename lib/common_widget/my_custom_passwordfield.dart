import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPasswordTextFormField extends StatefulWidget {
  final String hint;
  final TextInputType? kry;
  final double? width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;

  final TextEditingController? controller;

  MyPasswordTextFormField({
    @override required this.hint,
    this.width,
    this.kry,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
  });

  @override
  _MyPasswordTextFormFieldState createState() =>
      _MyPasswordTextFormFieldState();
}

class _MyPasswordTextFormFieldState extends State<MyPasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText == true ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        fillColor: const Color(0xFFF0F0F0),
        filled: true,
        hintText: widget.hint,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(color: Color(0xFFF0F0F0), width: 2.w)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(color: Color(0xFFF0F0F0), width: 2.w)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
                color: Color.fromRGBO(240, 240, 240, 100), width: 2.w)),
      ),
    );
  }
}
