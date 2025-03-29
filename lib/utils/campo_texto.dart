import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_sus/utils/colors.dart';

class CampoTexto extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color fillColor;
  final double contentPadding;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters; // Adicionado

  const CampoTexto({
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.textInputAction,
    this.focusNode,
    this.fillColor = Colors.white,
    this.contentPadding = 12,
    this.enabled = true,
    this.inputFormatters, // Adicionado
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus,
      textInputAction: textInputAction,
      focusNode: focusNode,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        floatingLabelStyle: TextStyle(
          color: marianBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(
          color: Color.lerp(jetBlack, marianBlue, 0.7),
          fontWeight: FontWeight.bold,
          // backgroundColor: Colors.white,
        ),
        contentPadding: EdgeInsets.all(contentPadding),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: jetBlack, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: marianBlue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: jetBlack, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
