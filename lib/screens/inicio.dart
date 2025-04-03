import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(color: whiteSmoke, child: Center(child: Text('Início'))),
    );
  }
}
