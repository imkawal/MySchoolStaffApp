import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatefulWidget {
  final String buttonName;
  final Function onTap;
  final double? height;
  final double? width;
  final bool isIconShow;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? topMargin;
  final double? fontSize;
  final FontWeight? fontweight;

  const AppButton({
    Key? key,
     required this.buttonName,
    required this.onTap,
     this.height,
     this.width,
     required this.isIconShow,
     this.icon,
     this.backgroundColor,
     this.textColor,
     this.iconColor,
    this.fontSize,
    this.fontweight,
    this.topMargin,
  }) : super(key: key);

  @override
   AppButtonState createState() => AppButtonState();
}

/// ----------Common button which we can use in both cases - with Icon and without Icon ---------
class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: _screenSize.width * .86,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        margin: EdgeInsets.only(top: widget.topMargin ?? 0.0),
        //width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          onPressed: () {
            widget.onTap();
          },
          style: ElevatedButton.styleFrom(
            primary: widget.backgroundColor,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
          ),
          child: (widget
              .isIconShow) // If "isIconShow"is true then we will make icon visible.
              ? FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.buttonName,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontweight,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: widget.icon == Icons.skip_next ? 25 : 15,
                ),
              ],
            ),
          )
              : FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.buttonName,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: widget.fontweight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// class AppButton extends StatefulWidget {
//   final String buttonName;
//   final Function onTap;
//   final double? height;
//   final double? width;
//   final bool isIconShow;
//   final IconData? icon;
//   final Color? backgroundColor;
//   final Color? textColor;
//   final Color? iconColor;
//   final double? topMargin;
//   final double? fontSize;
//   final FontWeight? fontweight;
//
//   const AppButton({
//     Key? key,
//     required this.buttonName,
//     required this.onTap,
//     this.height,
//     this.width,
//     required this.isIconShow,
//     this.icon,
//     this.backgroundColor,
//     this.textColor,
//     this.iconColor,
//     this.fontSize,
//     this.fontweight,
//     this.topMargin,
//   }) : super(key: key);
//
//   @override
//   AppButtonState createState() => AppButtonState();
// }
//
// /// ----------Common button which we can use in both cases - with Icon and without Icon ---------
// class AppButtonState extends State<AppButton> {
//   @override
//   Widget build(BuildContext context) {
//     // Size _screenSize = MediaQuery.of(context).size;
//     return Center(
//       child: Container(
//         //width: _screenSize.width * .86,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(35),
//         ),
//         margin: EdgeInsets.only(top: widget.topMargin ?? 0.0),
//         width: widget.width,
//         height: widget.height,
//         child: ElevatedButton(
//           onPressed: () {
//             widget.onTap();
//           },
//           style: ElevatedButton.styleFrom(
//             primary: widget.backgroundColor,
//             padding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(35),
//             ),
//           ),
//           child: (widget
//               .isIconShow) // If "isIconShow"is true then we will make icon visible.
//               ? FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.buttonName,
//                   style: TextStyle(
//                     color: widget.textColor,
//                     fontSize: widget.fontSize,
//                     fontWeight: widget.fontweight,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 5.0,
//                 ),
//                 Icon(
//                   widget.icon,
//                   color: widget.iconColor,
//                   size: widget.icon == Icons.skip_next ? 25 : 15,
//                 ),
//               ],
//             ),
//           )
//               : FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               widget.buttonName,
//               style: TextStyle(
//                 color: widget.textColor,
//                 fontSize: widget.fontSize,
//                 fontWeight: widget.fontweight,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }