import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: whiteSmoke,
        child: Center(
          child: Text('Agendar'),
        ),
      ),
    );
  }
}
