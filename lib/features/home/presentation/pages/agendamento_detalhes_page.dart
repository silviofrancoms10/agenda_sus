// Caminho: lib/features/home/presentation/pages/agendamento_detalhes_page.dart

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Removido, pois não usaremos mais DateFormat para a seleção do paciente

// Importe suas classes de cores e widgets compartilhados
import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:agenda_sus/shared/widgets/campo_texto.dart';

// Importe os modelos de dados relacionados ao agendamento
import 'package:agenda_sus/features/agendamento/data/models/especialidade.dart';
import 'package:agenda_sus/features/agendamento/data/models/consulta_model.dart'; // Contém PreferenciaHorario e StatusConsulta

class AgendamentoDetalhesPage extends StatefulWidget {
  final Especialidade especialidade;

  const AgendamentoDetalhesPage({super.key, required this.especialidade});

  @override
  State<AgendamentoDetalhesPage> createState() => _AgendamentoDetalhesPageState();
}

class _AgendamentoDetalhesPageState extends State<AgendamentoDetalhesPage> {
  final _formKey = GlobalKey<FormState>();
  String? _localAtendimentoSelecionado;
  String? _descricao;
  PreferenciaHorario? _preferenciaHorario;

  // Lista fake de unidades de saúde
  final List<String> _unidadesSaude = [
    'UBS 26 de Agosto',
    'UBS Coronel Antonino',
    'UBS Marabá',
    'UBS Tiradentes',
    'UBS Universitário',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void _agendarConsulta() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final DateTime dataHoraAtualParaBackend = DateTime.now(); // Placeholder

      final novaConsulta = ConsultaModel(
        especialidade: widget.especialidade,
        descricao: _descricao,
        localAtendimento: _localAtendimentoSelecionado!,
        dataHoraConsulta: dataHoraAtualParaBackend,
        preferenciaHorario: _preferenciaHorario,
      );

      print('--- Requisição de Consulta a ser enviada ---');
      print('Especialidade: ${novaConsulta.especialidade.descricao}');
      print('Descrição: ${novaConsulta.descricao ?? "Não informada"}');
      print('Local de Atendimento Solicitado: ${novaConsulta.localAtendimento}');
      print('Preferência de Horário: ${novaConsulta.preferenciaHorario?.descricao ?? "Não informada"}');
      print('Payload JSON para o Backend: ${novaConsulta.toJson()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sua requisição de consulta de ${widget.especialidade.descricao} para "${novaConsulta.localAtendimento}" foi enviada! Aguarde a confirmação.'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitar ${widget.especialidade.descricao}',
          style: TextStyle(color: whiteSmoke),
        ),
        backgroundColor: marianBlue,
        iconTheme: IconThemeData(color: whiteSmoke),
      ),
      backgroundColor: vistaBlue,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Alterado para Column para colocar o container de aviso acima do Form
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // **NOVO CONTAINER DE AVISO**
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 20.0), // Espaçamento abaixo do container
              decoration: BoxDecoration(
                color: whiteSmoke, // Um tom suave de amarelo para aviso
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade400, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atenção Importante:',
                    style: TextStyle(
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• A responsável pela solicitação deverá comparecer na hora marcada para a consulta.',
                    style: TextStyle(color: Colors.amber.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Será necessário confirmar a consulta quando houver ligação de confirmação agendamento for feita para você.',
                    style: TextStyle(color: Colors.amber.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Ao solicitar, você aceita os Termos de Uso e Política de Privacidade do AgendaSUS.',
                    style: TextStyle(color: Colors.amber.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Em caso de não comparecimento sem aviso prévio, o usuário poderá ser bloqueado de solicitar novos agendamentos por um período determinado.',
                    style: TextStyle(color: Colors.amber.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // **FIM DO NOVO CONTAINER DE AVISO**

            Form( // O formulário de agendamento
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Detalhes da Solicitação:',
                    style: TextStyle(
                      color: whiteSmoke,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Local de Atendimento Preferencial',
                      labelStyle: TextStyle(
                        color: jetBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: jetBlack, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: jetBlack, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: marianBlue, width: 2),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: _localAtendimentoSelecionado,
                    onChanged: (String? newValue) {
                      setState(() {
                        _localAtendimentoSelecionado = newValue;
                      });
                    },
                    onSaved: (value) => _localAtendimentoSelecionado = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione um local de atendimento';
                      }
                      return null;
                    },
                    items: _unidadesSaude.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: jetBlack),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: jetBlack),
                    icon: Icon(Icons.arrow_drop_down, color: jetBlack),
                  ),
                  const SizedBox(height: 16),

                  CampoTexto(
                    labelText: 'Descrição (Opcional)',
                    hintText: 'ex: Dor de cabeça, check-up anual, sintomas específicos',
                    maxLines: 5,
                    minLines: 3,
                    onSaved: (value) => _descricao = value,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<PreferenciaHorario>(
                    decoration: InputDecoration(
                      labelText: 'Preferência de Horário (Opcional)',
                      labelStyle: TextStyle(
                        color: jetBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: jetBlack, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: jetBlack, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: marianBlue, width: 2),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: _preferenciaHorario,
                    onChanged: (PreferenciaHorario? newValue) {
                      setState(() {
                        _preferenciaHorario = newValue;
                      });
                    },
                    onSaved: (value) => _preferenciaHorario = value,
                    items: PreferenciaHorario.values.map<DropdownMenuItem<PreferenciaHorario>>((PreferenciaHorario value) {
                      return DropdownMenuItem<PreferenciaHorario>(
                        value: value,
                        child: Text(
                          value.descricao,
                          style: TextStyle(color: jetBlack),
                        ),
                      );
                    }).toList(),
                    style: TextStyle(color: jetBlack),
                    icon: Icon(Icons.arrow_drop_down, color: jetBlack),
                  ),
                  const SizedBox(height: 48),

                  ElevatedButton(
                    onPressed: _agendarConsulta,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(marianBlue),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Enviar Solicitação',
                      style: TextStyle(
                        color: whiteSmoke,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}