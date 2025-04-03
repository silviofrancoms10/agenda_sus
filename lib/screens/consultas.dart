import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({super.key});

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
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
