import 'package:flutter/material.dart';
import 'package:vienna_is/view/widgets/text.dart';

class BtnWidget extends StatelessWidget {
  final VoidCallback onPress;
  final Color? btnColor;
  final Color? outlineColor;
  final ShapeBorder? shape;
  final double? width;
  final double? height;
  final double? radius;
  final TextWidget? textWidget;

  const BtnWidget(
      {Key? key,
      required this.onPress,
      this.btnColor,
      this.outlineColor,
      this.shape,
      this.width,
      this.height,
      this.radius,
      required this.textWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(btnColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 0.0),
                side: BorderSide(color: outlineColor ?? Colors.transparent),
              ))),
          child: textWidget),
    );
  }
}
