import 'package:agenda_sus/shared/widgets/botao_personalizado.dart';
import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Importe a enumeração Especialidade para passar o tipo de serviço para a próxima tela
import 'package:agenda_sus/features/agendamento/data/models/especialidade.dart';

// Este import já estava correto para o novo local da AgendamentoDetalhesPage
import 'package:agenda_sus/features/home/presentation/pages/agendamento_detalhes_page.dart';


class AgendarPage extends StatefulWidget {
  const AgendarPage({super.key});

  @override
  State<AgendarPage> createState() => _AgendarPageState();
}

class _AgendarPageState extends State<AgendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vistaBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
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
            const SizedBox(height: 32),

            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BotaoPersonalizado(
                          texto: "MÉDICO",
                          icone: FontAwesomeIcons.userDoctor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgendamentoDetalhesPage(especialidade: Especialidade.medico),
                              ),
                            );
                          },
                        ),
                        BotaoPersonalizado(
                          texto: "ENFERMEIRO",
                          icone: FontAwesomeIcons.userNurse,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgendamentoDetalhesPage(especialidade: Especialidade.enfermeiro),
                              ),
                            );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgendamentoDetalhesPage(especialidade: Especialidade.dentista),
                              ),
                            );
                          },
                        ),
                        BotaoPersonalizado(
                          texto: "EXAMES",
                          icone: FontAwesomeIcons.vial,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgendamentoDetalhesPage(especialidade: Especialidade.exames),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}