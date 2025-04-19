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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Stack(
              children: [
                Text(
                  "Olá, Nome",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground:
                        Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = jetBlack,
                  ),
                ),
                Text(
                  "Olá, Nome",
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
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Avisos:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text('Campanha de vacinação xyz 20/04 a 30/06'),
                    Text('Procure a UBS mais próxima'),
                    SizedBox(height: 32),
                    Text(
                      'Proximas Consultas:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Consulta Clinico Geral com Dr. Xi Jinping'),
                    Text('20/04 às 14:30 - UBS Marabá'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
