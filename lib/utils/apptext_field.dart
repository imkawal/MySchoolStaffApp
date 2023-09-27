import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appcolors_theme.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNodeName;
  final String? Function(String?)? validator;
  final FocusNode? nextFocus;
  final Widget? prefix;
  final Text? title;
  final TextEditingController? controller;
  final bool obscureText;
  final bool visibleText;
  final TextInputType? keyboardType;

  const  AppTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.focusNodeName,
    this.validator,
    this.nextFocus,
    this.title,
    this.prefix,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.visibleText = false,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool _isVisible = true;
  // bool _textVisible = true;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding:  EdgeInsets.only(left: Get.width*0.05),
        //   child: SizedBox(
        //       // height: Get.height*0.05,
        //       // width: Get.width*0.06,
        //       child: widget.title,),
        // ),
        // SizedBox(height: Get.height*0.01,),
        SizedBox(
          width: screenSize.width * 0.86,
          //height: _screenSize.height*0.08,
          child: TextFormField(
            style: const TextStyle(
              color: AppColors.textcolor,
            ),
            controller: widget.controller,
            focusNode: widget.focusNodeName,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              // enabledBorder: const UnderlineInputBorder(
              //   borderSide: BorderSide(color: AppColors.bluishGrey),
              // ),
              hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor,
              fontFamily: "Montserrat"),
              // hintStyle: const TextStyle(color: AppColors.bluishGrey, fontSize: 20),
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor),
              errorMaxLines: 5,
              // show password
              prefixIcon : widget.prefix,
             //  suffixIcon: widget.obscureText
             //      ? IconButton(
             //    icon: Icon(
             //      _isVisible ? Icons.visibility_off : Icons.visibility,
             //      color: AppColors.grey,
             //    ),
             //    onPressed: () {
             //      setState(() => _isVisible = !_isVisible);
             //    },
             //  )
             //      : null,
             suffixIcon : widget.obscureText
                 ? TextButton(
                 onPressed: (){
                   setState(() => _isVisible = !_isVisible);
                 },
                 child: _isVisible  ? const Icon(Icons.visibility_outlined,
                 color: AppColors.textcolor,)
                     : const Icon(Icons.visibility_off_outlined,
                 color: AppColors.textcolor,),)
        : null,

             fillColor: const Color(0xffF4F9FF),
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                      color: AppColors.bordercolor,
                      width: 1.2
                  ),
                ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(
                  color: AppColors.bordercolor,
                    width: 1.2
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(
                  color: AppColors.bordercolor,
                    width: 1.2
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(
                    color: Color(0xffEA4D4D),
                    width: 1.2
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.0),
                borderSide: const BorderSide(
                    color: AppColors.bordercolor,
                    width: 1.2
                ),
              ),
              contentPadding:  EdgeInsets.only(left: 25,top: Get.height*0.05),
              //filled: true,

            ),
            //  unfocus on the tap on screen
            textInputAction: widget.nextFocus != widget.focusNodeName
                ? TextInputAction.next
                : TextInputAction.done,
            onEditingComplete: () {
              if(widget.nextFocus != widget.focusNodeName) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(widget.nextFocus);
              } else {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            cursorColor: Theme.of(context).hoverColor,

            //for Password obsure field
            obscureText: widget.obscureText ? _isVisible : false,
          ),
        ),
      ],
    );
  }
}


class AssignmentTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNodeName;
  final String? Function(String?)? validator;
  final FocusNode? nextFocus;
  final Widget? prefix;
  final Text? title;
  final TextEditingController? controller;
  final bool obscureText;
  final bool visibleText;
  final TextInputType? keyboardType;

  const  AssignmentTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.focusNodeName,
    this.validator,
    this.nextFocus,
    this.title,
    this.prefix,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.visibleText = false,
  }) : super(key: key);

  @override
  AssignmentTextFieldState createState() => AssignmentTextFieldState();
}

class AssignmentTextFieldState extends State<AssignmentTextField> {
  bool _isVisible = true;
  // bool _textVisible = true;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenSize.width * 0.8,
          height: screenSize.height*0.07,
          child: TextFormField(
            style: const TextStyle(
              color: AppColors.textcolor,
            ),
            controller: widget.controller,
            focusNode: widget.focusNodeName,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              // enabledBorder: const UnderlineInputBorder(
              //   borderSide: BorderSide(color: AppColors.bluishGrey),
              // ),
              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textcolor),
              // hintStyle: const TextStyle(color: AppColors.bluishGrey, fontSize: 20),
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor),
              errorMaxLines: 5,
              // show password
              prefixIcon : widget.prefix,
              //  suffixIcon: widget.obscureText
              //      ? IconButton(
              //    icon: Icon(
              //      _isVisible ? Icons.visibility_off : Icons.visibility,
              //      color: AppColors.grey,
              //    ),
              //    onPressed: () {
              //      setState(() => _isVisible = !_isVisible);
              //    },
              //  )
              //      : null,
              suffixIcon : widget.obscureText
                  ? TextButton(
                onPressed: (){
                  setState(() => _isVisible = !_isVisible);
                },
                child: _isVisible  ? const Icon(Icons.visibility,
                  color: AppColors.textcolor,)
                    : const Icon(Icons.visibility_off,
                  color: AppColors.textcolor,),)
                  : null,

              fillColor: const Color(0xffF4F9FF),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.darkblue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: AppColors.darkblue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: AppColors.darkblue,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                    color: Color(0xffEA4D4D)
                ),
              ),
              contentPadding:  EdgeInsets.only(left: 10,top: Get.height*0.05),
              //filled: true,

            ),
            //  unfocus on the tap on screen
            textInputAction: widget.nextFocus != widget.focusNodeName
                ? TextInputAction.next
                : TextInputAction.done,
            onEditingComplete: () {
              if(widget.nextFocus != widget.focusNodeName) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(widget.nextFocus);
              } else {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            cursorColor: Theme.of(context).hoverColor,

            //for Password obsure field
            obscureText: widget.obscureText ? _isVisible : false,
          ),
        ),
      ],
    );
  }
}