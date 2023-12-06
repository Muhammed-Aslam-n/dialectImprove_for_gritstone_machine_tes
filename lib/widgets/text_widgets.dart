
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
showCustomSnackBar({
  required context,
  message,
  bgColor,
  textColor,
  duration,
  success,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      message,style: textColor,
    ),
    duration: duration,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),backgroundColor: bgColor ?? success ? Colors.green : Colors.redAccent,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// class PoppinsText extends StatelessWidget {
//   final String data;
//   final Color? color;
//   final FontWeight? fontWeight;
//   final double? fontSize, letterSpacing, wordSpacing;
//   final FontStyle? fontStyle;
//
//   const PoppinsText(
//       {Key? key,
//         required this.data,
//         this.color,
//         this.fontWeight,
//         this.fontSize,
//         this.letterSpacing,
//         this.wordSpacing,
//         this.fontStyle})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       data,
//       style: GoogleFonts.poppins(
//         color: color,
//         fontWeight: fontWeight,
//         fontSize: fontSize,
//         letterSpacing: letterSpacing,
//         fontStyle: fontStyle,
//         wordSpacing: wordSpacing,
//       ),
//     );
//   }
// }