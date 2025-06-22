import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:agenda_sus/features/home/presentation/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _homeController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeController = Provider.of<HomeController>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight / 2.4;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Stack(
              children: [
                Observer(builder: (_) {
                  return Text(
                    "Olá, ${_homeController.nomeExibicao.isEmpty ? 'Usuário' : _homeController.nomeExibicao}",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = jetBlack,
                    ),
                  );
                }),
                Observer(builder: (_) {
                  return Text(
                    "Olá, ${_homeController.nomeExibicao.isEmpty ? 'Usuário' : _homeController.nomeExibicao}",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: whiteSmoke,
                    ),
                  );
                }),
              ],
            ),
          ),
          
          Spacer(),

          Container(
            height: containerHeight,
            width: double.infinity,
            color: whiteSmoke,
            padding: const EdgeInsets.all(16.0),
            child: Observer(builder: (_) {
              return ListView(
                children: [
                  Text(
                    'Avisos:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: jetBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._homeController.avisos.map((aviso) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '- $aviso',
                      style: TextStyle(color: jetBlack),
                    ),
                  )).toList(),

                  if (_homeController.avisos.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Nenhum aviso no momento.',
                        style: TextStyle(color: jetBlack.withOpacity(0.7)),
                      ),
                    ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'Próximas Consultas:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: jetBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._homeController.proximasConsultas.map((consulta) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- ${consulta['descricao']}',
                          style: TextStyle(color: jetBlack, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '  ${consulta['dataHora']} - ${consulta['local']}',
                          style: TextStyle(color: jetBlack.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  )).toList(),

                  if (_homeController.proximasConsultas.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Nenhuma consulta agendada.',
                        style: TextStyle(color: jetBlack.withOpacity(0.7)),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
