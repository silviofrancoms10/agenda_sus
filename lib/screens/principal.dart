import 'package:agenda_sus/screens/agendar.dart';
import 'package:agenda_sus/screens/cartao_sus.dart';
import 'package:agenda_sus/screens/consultas.dart';
import 'package:agenda_sus/screens/inicio.dart';
import 'package:agenda_sus/screens/perfil.dart';
import 'package:agenda_sus/utils/colors.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _indiceAtual = 0;

  @override
  List<Widget> telas = [
    Inicio(),
    Consultas(),
    Agendar(),
    CartaoSUS(
      nome: "Maria da Silva",
      numeroCartao: "123 4567 8901 2345",
      dataNascimento: "15/07/1985",
      sexo: "Masculino",
    ),
    Perfil(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: EdgeInsets.all(16), child: telas[_indiceAtual]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) => setState(() => _indiceAtual = indice),
        type: BottomNavigationBarType.fixed,
        fixedColor: marianBlue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35, weight: 900),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, size: 35, weight: 900),
            label: "Consultas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, size: 40, weight: 900),
            label: "Agendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, size: 35, weight: 900),
            label: "CartãoSUS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, size: 35, weight: 900),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
