import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final String _nomeUsuarioLogado = "Nome do Usuário";

  @observable
  String nomeExibicao = "";

  @observable
  ObservableList<String> avisos = ObservableList<String>();

  @observable
  ObservableList<Map<String, String>> proximasConsultas = ObservableList<Map<String, String>>();

  _HomeController() {
    _loadMockData();
  }

  @action
  void setNomeUsuario(String nome) {
    nomeExibicao = nome.split(' ').first;
  }

  @action
  void _loadMockData() {
    avisos.addAll([
      'Campanha de vacinação contra a gripe de 20/04 a 30/06. Procure a UBS mais próxima!',
      'Horário de atendimento estendido na UBS Centro até as 20h a partir de 01/07.',
      'Novo protocolo para agendamento de exames a partir de 15/07. Consulte o site.',
    ]);

    proximasConsultas.addAll([
      {
        'descricao': 'Consulta Clínica Geral com Dr. João Silva',
        'dataHora': '20/07 às 14:30',
        'local': 'UBS Marabá',
      },
      {
        'descricao': 'Retorno com Dra. Ana Costa (Pediatria)',
        'dataHora': '25/07 às 09:00',
        'local': 'Hospital Central',
      },
    ]);
  }
}
