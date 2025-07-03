// lib/features/agendamento/data/models/consulta_model.dart

import 'package:agenda_sus/features/agendamento/data/models/especialidade.dart'; // Importa Especialidade do seu próprio arquivo

enum PreferenciaHorario {
  matutino(0, "Matutino"),
  vespertino(1, "Vespertino");

  final int codigo;
  final String descricao;

  const PreferenciaHorario(this.codigo, this.descricao);

  factory PreferenciaHorario.fromCodigo(int codigo) {
    return PreferenciaHorario.values.firstWhere(
      (e) => e.codigo == codigo,
      orElse: () => throw ArgumentError('Código de preferência de horário inválido: $codigo'),
    );
  }

  @override
  String toString() => descricao;
}

enum StatusConsulta {
  agendada(0, "Agendada"),
  confirmada(1,"Confirmada pelo Atendente"),
  realizada(2, "Realizada"),
  cancelada(3, "Cancelada");

  final int codigo;
  final String descricao;

  const StatusConsulta(this.codigo, this.descricao);

  factory StatusConsulta.fromCodigo(int codigo) {
    return StatusConsulta.values.firstWhere(
      (e) => e.codigo == codigo,
      orElse: () => throw ArgumentError('Código de status de consulta inválido: $codigo'),
    );
  }

  @override
  String toString() => descricao;
}

class ConsultaModel {
  final Especialidade especialidade; // Agora vem do import de especialidade.dart
  final String? descricao;
  final String localAtendimento;
  final DateTime dataHoraConsulta; 
  final PreferenciaHorario? preferenciaHorario;

  ConsultaModel({
    required this.especialidade,
    this.descricao,
    required this.localAtendimento,
    required this.dataHoraConsulta,
    this.preferenciaHorario,
  });

  Map<String, dynamic> toJson() {
    return {
      'especialidade': especialidade.codigo,
      'descricao': descricao,
      'localAtendimento': localAtendimento,
      'dataHoraConsulta': '${dataHoraConsulta.day.toString().padLeft(2, '0')}/'
                          '${dataHoraConsulta.month.toString().padLeft(2, '0')}/'
                          '${dataHoraConsulta.year} '
                          '${dataHoraConsulta.hour.toString().padLeft(2, '0')}:'
                          '${dataHoraConsulta.minute.toString().padLeft(2, '0')}',
      'preferenciaHorario': preferenciaHorario?.codigo,
    };
  }

  factory ConsultaModel.fromJson(Map<String, dynamic> json) {
    return ConsultaModel(
      especialidade: Especialidade.fromCodigo(json['especialidade'] as int),
      descricao: json['descricao'] as String?,
      localAtendimento: json['localAtendimento'] as String,
      dataHoraConsulta: _parseBackendDateTime(json['dataHoraConsulta'] as String),
      preferenciaHorario: json['preferenciaHorario'] != null
          ? PreferenciaHorario.fromCodigo(json['preferenciaHorario'] as int)
          : null,
    );
  }

  static DateTime _parseBackendDateTime(String dateTimeString) {
    final RegExp regex = RegExp(r'(\d{2})/(\d{2})/(\d{4}) (\d{2}):(\d{2})');
    final Match? match = regex.firstMatch(dateTimeString);

    if (match != null) {
      final int day = int.parse(match.group(1)!);
      final int month = int.parse(match.group(2)!);
      final int year = int.parse(match.group(3)!);
      final int hour = int.parse(match.group(4)!);
      final int minute = int.parse(match.group(5)!);
      return DateTime(year, month, day, hour, minute);
    } else {
      throw FormatException('Formato de data e hora inesperado do backend: $dateTimeString');
    }
  }
}