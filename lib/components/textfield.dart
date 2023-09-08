import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldWidget extends StatelessWidget {
  late TextEditingController controller = TextEditingController();
  late IconData prefixIcon;
  late bool? obscure;
  Widget? suffixIcon;
  late String labelText;
  late String hintText;
  //  Color? fillColor;
  //  bool? filled=false;

  TextFieldWidget({
  super.key,
  required this.controller,
  required this.prefixIcon,
  required this.hintText,
  required this.labelText,
  this.obscure = false,
  this.suffixIcon,
  //this.fillColor,
  //this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      maxLines: null,
      style:  TextStyle(
        color: kSecondaryColor,
      ),

      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon,color: kSecondaryColor,),
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),
          enabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),

          filled: true,
          fillColor:kThirdColor


      ),
    );
  }
}




class TextFormFieldWidget extends StatelessWidget {
  late TextEditingController? controller = TextEditingController();
  late IconData prefixIcon;
  late bool? obscure;
  Widget? suffixIcon;
  late String labelText;
  late String hintText;
  final String? Function(String?)? validator; // Accepts custom validator function
  String? Function(String?)? onChanged;
  String ? initialValue;
  InputDecoration? decoration;
   bool readonly;
   bool enabled;
  //  Color? fillColor;
  //  bool? filled=false;

  TextFormFieldWidget({
  super.key,
  this.controller,
  required this.prefixIcon,
  required this.hintText,
  required this.labelText,
  this.obscure = false,
  this.suffixIcon,
  this.validator,
  this.initialValue,
  this.onChanged, this.decoration,
  this.readonly=false,
  this.enabled=true,
  //this.fillColor,
  //this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style:  TextStyle(
        color: kSecondaryColor,
      ),

      initialValue: initialValue,
      onChanged:onChanged ,
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon,color: kSecondaryColor,),
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: kSecondaryColor),
          ),


          filled: true,
          fillColor:kThirdColor


      ),
      validator:validator,
      readOnly: readonly,
      enabled: enabled,

    );
  }
}
