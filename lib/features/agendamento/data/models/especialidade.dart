// lib/features/agendamento/data/models/especialidade.dart
enum Especialidade {
  medico(0, "Médico"),
  enfermeiro(1, "Enfermeiro"),
  dentista(2, "Dentista"),
  exames(3, "Exames");

  final int codigo;
  final String descricao;

  const Especialidade(this.codigo, this.descricao);

  factory Especialidade.fromCodigo(int codigo) {
    return Especialidade.values.firstWhere(
      (e) => e.codigo == codigo,
      orElse: () => throw ArgumentError('Código de especialidade inválido: $codigo'),
    );
  }

  @override
  String toString() => descricao;
}