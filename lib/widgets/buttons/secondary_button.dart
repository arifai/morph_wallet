import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/size_config.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  const SecondaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: MorphColor.greyColor,
        ),
      ),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(
            SizeConfig.blockSizeVertical * 41,
            SizeConfig.blockSizeHorizontal * 13,
          ),
        ),
      ),
    );

    //   return CustomPaint(
    //     size: Size(
    //       SizeConfig.blockSizeVertical * 41,
    //       SizeConfig.blockSizeHorizontal * 13,
    //     ),
    //     painter: Painter(
    //       gradient: const LinearGradient(
    //         colors: [
    //           MorphColor.pinkColor,
    //           MorphColor.primaryColor,
    //         ],
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //       ),
    //     ),
    //     child: GestureDetector(
    //       onTap: onTap,
    //       behavior: HitTestBehavior.translucent,
    //       child: Text(
    //         title,
    //         style: const TextStyle(
    //           fontSize: 17.0,
    //           fontFamily: 'Poppins',
    //           fontWeight: FontWeight.bold,
    //           color: MorphColor.secondaryDarkColor,
    //         ),
    //       ),
    //     ),
    //   );
  }
}

// class Painter extends CustomPainter {
//   final Paint _paint = Paint();
//   final Gradient gradient;

//   Painter({required this.gradient});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Rect outerRect = Offset.zero & size;
//     var outerRRect =
//         RRect.fromRectAndRadius(outerRect, const Radius.circular(8.0));

//     Rect innerRect =
//         Rect.fromLTWH(2, 2, size.width - 2 * 2, size.height - 2 * 2);
//     var innerRRect = RRect.fromRectAndRadius(
//       innerRect,
//       const Radius.circular(8.0 - 2),
//     );

//     _paint.shader = gradient.createShader(outerRect);

//     Path path1 = Path()..addRRect(outerRRect);
//     Path path2 = Path()..addRRect(innerRRect);
//     var path = Path.combine(PathOperation.difference, path1, path2);

//     canvas.drawPath(path, _paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) =>
//       oldDelegate != this;
// }
