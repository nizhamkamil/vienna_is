import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final bool isGreenBackground;
  final FontWeight weight;
  final TextAlign textAlign;
  final int maxLines;
  final Color? color;
  final String? style;
  final TextOverflow? overflow;

  const TextWidget(
      {Key? key,
      required this.text,
      this.size = 14.0,
      this.weight = FontWeight.normal,
      this.textAlign = TextAlign.left,
      this.maxLines = 1,
      this.isGreenBackground = false,
      this.color,
      this.style,
      this.overflow})
      : super(key: key);
  const TextWidget.title(
      {Key? key,
      required this.text,
      this.size = 36.0,
      this.weight = FontWeight.normal,
      this.textAlign = TextAlign.center,
      this.maxLines = 1,
      this.isGreenBackground = false,
      this.color = Colors.black,
      this.style,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGreenBackground) {
      return AutoSizeText(text,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color ?? Colors.grey[200]));
    } else {
      return AutoSizeText(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.poppins(
            fontSize: size,
            fontWeight: weight,
            color: color ?? Theme.of(context).textSelectionTheme.selectionColor,
            decoration:
                style == null ? TextDecoration.none : TextDecoration.underline),
      );
    }
  }
}
