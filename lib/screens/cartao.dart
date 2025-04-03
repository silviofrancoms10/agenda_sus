import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Cartao extends StatefulWidget {
  const Cartao({super.key});

  @override
  State<Cartao> createState() => _CartaoState();
}

class _CartaoState extends State<Cartao> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: whiteSmoke,
        child: Center(
          child: Text('cartao'),
        ),
      ),
    );
  }
}
