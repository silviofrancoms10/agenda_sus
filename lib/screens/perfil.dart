import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: whiteSmoke,
        child: Center(
          child: Text('Consultas'),
        ),
      ),
    );
  }
}
