// lib/shared/widgets/campo_texto.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_sus/shared/utils/colors.dart';

class CampoTexto extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enabled;
  // O parâmetro maxLines já existe
  final int? maxLines;
  final VoidCallback? onTap;
  final bool? readOnly;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  // **ADICIONADO:** O novo parâmetro minLines
  final int? minLines;


  const CampoTexto({
    super.key,
    required this.labelText,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.controller,
    this.enabled,
    this.maxLines = 1, // Valor padrão de 1 para maxLines
    this.onTap,
    this.readOnly = false,
    this.onSaved,
    this.onFieldSubmitted,
    // **ADICIONADO:** Inclua no construtor.
    // Defina um valor padrão razoável se não quiser torná-lo obrigatório
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      validator: validator,
      enabled: enabled,
      // **ADICIONADO:** Passe o minLines para o TextFormField
      minLines: minLines, // Use o valor passado ou o padrão do TextFormField (1)
      maxLines: maxLines, // Já existia, mas aqui é onde ele é passado
      onTap: onTap,
      readOnly: readOnly ?? false,

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: jetBlack,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(color: jetBlack.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: jetBlack, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: jetBlack, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: marianBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red.shade700, width: 2),
        ),
      ),
      style: TextStyle(color: jetBlack),
      cursorColor: marianBlue,
    );
  }
}