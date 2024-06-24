import 'package:flutter/material.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';

/// ::::: Common Button :::::
class CommonButton extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final double? radius;
  final double buttonSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const CommonButton({
    super.key,
    required this.onTap,
    this.radius,
    this.fontWeight = FontWeight.w400,
    this.buttonSize = numD04,
    required this.buttonText,
    this.borderColor,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            size.width * (widget.radius ?? numD01),
          ),
          side: BorderSide(
            color: widget.borderColor ?? CommonColors.appThemeColor,
            width: 1.5,
          ),
        ),
        backgroundColor: widget.buttonColor ?? CommonColors.appThemeColor,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: size.width * numD015,
          horizontal: size.width * numD09,
        ),
      ),
      child: CommonText(
        title: widget.buttonText,
        fontSize: size.width * numD038,
        color: widget.buttonTextColor ?? Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
