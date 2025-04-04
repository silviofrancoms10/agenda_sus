import 'package:agenda_sus/utils/botao_personalizado.dart';
import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Agendar extends StatefulWidget {
  const Agendar({super.key});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Stack(
              children: [
                Text(
                  "Agendar Consulta",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = jetBlack,
                  ),
                ),
                Text(
                  "Agendar Consulta",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: whiteSmoke,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 380,
            color: whiteSmoke,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BotaoPersonalizado(
                      texto: "MÉDICO",
                      icone: FontAwesomeIcons.userDoctor,
                      onPressed: () {
                        // Navigator.push(...);
                      },
                    ),
                    BotaoPersonalizado(
                      texto: "ENFERMEIRO",
                      icone: FontAwesomeIcons.userNurse,
                      onPressed: () {
                        // Navigator.push(...);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BotaoPersonalizado(
                      texto: "DENTISTA",
                      icone: FontAwesomeIcons.tooth,
                      onPressed: () {
                        // Navigator.push(...);
                      },
                    ),
                    BotaoPersonalizado(
                      texto: "EXAMES",
                      icone: FontAwesomeIcons.vial,
                      onPressed: () {
                        // Navigator.push(...);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}