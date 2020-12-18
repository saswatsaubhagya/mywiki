import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget appTextField({
  bool isTextArea = false,
  bool readonly = false,
  String hinttext = "",
  String labelText,
  Function(String) onSaved,
  Function(String) validator,
  Function(String) onChanged,
  Function() onTap,
  IconData prefixIcon,
  Widget suffixIcon,
  double height,
  TextInputType keyboardType,
  FocusNode focusNode,
  TextInputAction textInputAction,
  Function(String) onFieldSubmitted,
  Color filledColor = Colors.white,
  bool isPassword = false,
  TextEditingController controller,
}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: TextFormField(
      readOnly: readonly,
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(height: height),
      maxLines: isTextArea ? null : 1,
      decoration: InputDecoration(
        fillColor: filledColor,
        filled: true,
        hintText: hinttext,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                // size: 18,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    ),
  );
}
