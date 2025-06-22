import 'package:agenda_sus/features/user_profile/data/models/endereco_profile_model.dart';

class UserProfileModel {
  final int? id;
  final String? nomeCompleto;
  final String? cpf;
  final String? cns;
  final String? senha;
  final String? dataNascimento;
  final int? genero;
  final String? email;
  final String? telefone;
  final EnderecoProfileModel? endereco;
  final bool? aceitaTermos;
  final bool? aceitaNotificacoes;
  final String? roles;
  final String? dataCriacao;
  final String? dataAtualizacao;

  const UserProfileModel({
    this.id,
    this.nomeCompleto,
    this.cpf,
    this.cns,
    this.senha,
    this.dataNascimento,
    this.genero,
    this.email,
    this.telefone,
    this.endereco,
    this.aceitaTermos,
    this.aceitaNotificacoes,
    this.roles,
    this.dataCriacao,
    this.dataAtualizacao,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: (json['id'] as num?)?.toInt(),
      nomeCompleto: json['nomeCompleto'] as String?,
      cpf: json['cpf'] as String?,
      cns: json['cns'] as String?,
      senha: json['senha'] as String?,
      dataNascimento: json['dataNascimento'] as String?,
      genero: (json['genero'] as num?)?.toInt(),
      email: json['email'] as String?,
      telefone: json['telefone'] as String?,
      endereco: json['endereco'] != null
          ? EnderecoProfileModel.fromJson(json['endereco'] as Map<String, dynamic>)
          : null,
      aceitaTermos: json['aceitaTermos'] as bool?,
      aceitaNotificacoes: json['aceitaNotificacoes'] as bool?,
      roles: json['roles'] as String?,
      dataCriacao: json['dataCriacao'] as String?,
      dataAtualizacao: json['dataAtualizacao'] as String?,
    );
  }
}