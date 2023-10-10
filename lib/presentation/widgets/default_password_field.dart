import 'package:flutter/material.dart';
import 'package:mobile/presentation/styles/colors.dart';
import 'package:sizer/sizer.dart';

class DefaultPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final bool password;
  final IconData? suffix;
  final ValueChanged? submit;
  final Widget? icon;

  const DefaultPasswordField({
    required this.controller,
    required this.hintText,
    this.submit,
    this.suffix,
    this.onTap,
    this.icon,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 1.h,
      ),
      child: Container(
        width: 90.w,
        height: 8.h,
        margin: EdgeInsets.symmetric(
          vertical: 0.8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: submit,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
          cursorColor: AppColors.purple,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: icon),
            alignLabelWithHint: true,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            filled: true,
            fillColor: AppColors.lightGray,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.transparent,
              ),
            ),
          ),
          obscureText: password,
        ),
      ),
    );
  }
}
