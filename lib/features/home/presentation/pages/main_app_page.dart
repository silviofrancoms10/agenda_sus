// lib/features/home/presentation/pages/main_app_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/features/auth/data/models/user_model.dart';
import 'package:agenda_sus/features/home/presentation/controllers/main_app_controller.dart';
import 'package:agenda_sus/features/home/presentation/controllers/home_controller.dart';
import 'package:agenda_sus/features/home/presentation/controllers/sus_card_controller.dart';
// Note: LoginController is not directly used here but can remain imported if needed elsewhere in the file.
// import 'package:agenda_sus/features/auth/presentation/controllers/login_controller.dart';

import 'package:agenda_sus/features/home/presentation/pages/home_page.dart';
import 'package:agenda_sus/features/home/presentation/pages/sus_card_page.dart';
import 'package:agenda_sus/features/home/presentation/pages/perfil.dart'; // Import da tela de Perfil refatorada

import 'package:agenda_sus/features/home/presentation/pages/agendar_page.dart'; // Assumindo que ainda está aqui
import 'package:agenda_sus/screens/consultas.dart'; // Assumindo que ainda está aqui

import 'package:agenda_sus/shared/utils/colors.dart';

class MainAppPage extends StatefulWidget {
  final UserModel usuario;

  const MainAppPage({super.key, required this.usuario});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  late MainAppController _mainAppController;
  late HomeController _homeController;
  late SusCardController _susCardController;

  late final List<Widget> telas;

  @override
  void initState() {
    super.initState();
    // AQUI ESTÁ A CORREÇÃO! Passe o 'usuario' para a página Perfil
    telas = [
      const HomePage(),
      const Consultas(), // Assumindo que Consultas não precisa de 'usuario'
      const AgendarPage(),   // Assumindo que Agendar não precisa de 'usuario'
      const SusCardPage(),
      Perfil(usuario: widget.usuario), // Certifique-se de passar o UserModel
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mainAppController = Provider.of<MainAppController>(context);
    _homeController = Provider.of<HomeController>(context);
    _susCardController = Provider.of<SusCardController>(context);

    _homeController.setNomeUsuario(widget.usuario.nomeCompleto);

    _susCardController.setCardData(
      nome: widget.usuario.nomeCompleto,
      numeroCartao: widget.usuario.cns,
      dataNascimento: widget.usuario.dataNascimento,
      sexo: widget.usuario.genero == 0 ? "Feminino" : "Masculino",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return telas[_mainAppController.indiceAtual];
        },
      ),

      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: _mainAppController.indiceAtual,
            onTap: _mainAppController.setIndiceAtual,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: marianBlue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Início",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: "Consultas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: "Agendar",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: "CartãoSUS",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Perfil",
              ),
            ],
          );
        },
      ),
    );
  }
}