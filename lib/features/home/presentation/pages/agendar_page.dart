import 'package:agenda_sus/shared/widgets/botao_personalizado.dart';
import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- ATENÇÃO AQUI: Importe 'Especialidade' de 'consulta_model.dart' ---
// REMOVIDO: import 'package:agenda_sus/features/agendamento/data/models/especialidade.dart';
// AGORA: Especialidade está definida dentro de consulta_model.dart
import 'package:agenda_sus/features/agendamento/data/models/consulta_model.dart'; // Este arquivo agora contém Especialidade

// Este import para AgendamentoDetalhesPage já estava correto em 'home/presentation/pages'
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
      backgroundColor: vistaBlue, // Cor de fundo do Scaffold
      body: SafeArea( // Garante que o conteúdo não invada a barra de status
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
          children: [
            // --- Seção do Título "Agendar Consulta" com estilo de contorno ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0), // Padding no título
              child: Stack( // Permite sobrepor texto para o efeito de contorno
                children: [
                  // Texto com contorno (preto semi-transparente)
                  Text(
                    "Agendar Consulta",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke // Estilo de traço
                        ..strokeWidth = 3 // Largura do contorno
                        ..color = jetBlack, // Cor do contorno
                    ),
                  ),
                  // Texto principal (branco fumaça)
                  Text(
                    "Agendar Consulta",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: whiteSmoke, // Cor do texto principal
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32), // Espaço entre o título e os botões

            // --- Seção dos Botões de Especialidade ---
            Expanded( // Permite que a área dos botões ocupe o espaço restante verticalmente
              child: Container(
                // Ocupa a largura total
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Alinha os botões ao final do espaço disponível
                  children: [
                    Row( // Primeira linha de botões
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribui os botões uniformemente
                      children: [
                        BotaoPersonalizado(
                          texto: "MÉDICO",
                          icone: FontAwesomeIcons.userDoctor,
                          onPressed: () {
                            // Navega para a tela de detalhes, passando a Especialidade.medico
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
                            // Navega para a tela de detalhes, passando a Especialidade.enfermeiro
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
                    const SizedBox(height: 16), // Espaço entre as linhas de botões
                    Row( // Segunda linha de botões
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BotaoPersonalizado(
                          texto: "DENTISTA",
                          icone: FontAwesomeIcons.tooth,
                          onPressed: () {
                            // Navega para a tela de detalhes, passando a Especialidade.dentista
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
                            // Navega para a tela de detalhes, passando a Especialidade.exames
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
                    SizedBox(height: 32,) // Espaço na parte inferior dos botões
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