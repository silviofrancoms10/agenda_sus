import 'package:agenda_sus/features/address/data/models/address_model.dart';

class UserModel {
  final int id;
  final String nomeCompleto;
  final String email;
  final String cpf;
  final String cns;
  final String dataNascimento;
  final int genero;
  final String? telefone; // <-- ADICIONADO AQUI
  final AddressModel endereco;
  final bool? aceitaTermos;       // <-- ADICIONADO AQUI (se vier do backend)
  final bool? aceitaNotificacoes; // <-- ADICIONADO AQUI (se vier do backend)


  UserModel({
    required this.id,
    required this.nomeCompleto,
    required this.email,
    required this.cpf,
    required this.cns,
    required this.dataNascimento,
    required this.genero,
    this.telefone, // <-- ADICIONADO AQUI
    required this.endereco,
    this.aceitaTermos,       // <-- ADICIONADO AQUI
    this.aceitaNotificacoes, // <-- ADICIONADO AQUI
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('🔍 CONVERTENDO JSON PARA USERMODEL: $json');
    
    try {
      // Tratamento especial para o campo genero
      int generoValue;
      if (json['genero'] is String) {
        final generoStr = json['genero'] as String;
        if (generoStr.toUpperCase() == 'MASCULINO' || generoStr == '1') {
          generoValue = 1;
        } else if (generoStr.toUpperCase() == 'FEMININO' || generoStr == '0') {
          generoValue = 0;
        } else {
          generoValue = 1; // Valor padrão
        }
      } else {
        generoValue = int.parse(json['genero'].toString());
      }

      // Tratamento seguro para o endereço
      AddressModel endereco;
      if (json['endereco'] != null && json['endereco'] is Map<String, dynamic>) {
        endereco = AddressModel.fromJson(json['endereco'] as Map<String, dynamic>);
      } else {
        // Endereço padrão se não existir
        endereco = AddressModel(
          cep: '',
          logradouro: '',
          complemento: '',
          bairro: '',
          localidade: '',
          uf: '',
        );
      }

      final userModel = UserModel(
        id: int.parse(json['id'].toString()),
        nomeCompleto: json['nomeCompleto'] as String? ?? 'Nome não informado',
        email: json['email'] as String? ?? '',
        cpf: json['cpf'] as String? ?? '',
        cns: json['cns'] as String? ?? '',
        dataNascimento: json['dataNascimento'] as String? ?? '',
        genero: generoValue,
        telefone: json['telefone'] as String?, // <-- Mapeando o telefone do JSON
        endereco: endereco,
        aceitaTermos: json['aceitaTermos'] as bool?,       // <-- Mapeando aceitaTermos
        aceitaNotificacoes: json['aceitaNotificacoes'] as bool?, // <-- Mapeando aceitaNotificacoes
      );

      print('✅ USERMODEL CRIADO COM SUCESSO: ${userModel.nomeCompleto}');
      return userModel;
      
    } catch (e, stackTrace) {
      print('❌ ERRO AO CRIAR USERMODEL: $e');
      print('📄 STACK TRACE: $stackTrace');
      print('📄 JSON PROBLEMÁTICO: $json');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nome: $nomeCompleto, email: $email, telefone: $telefone)';
  }

    // --- Opcional: Adicionar um método copyWith para facilitar atualizações em objetos imutáveis ---
  UserModel copyWith({
    int? id,
    String? nomeCompleto,
    String? email,
    String? cpf,
    String? cns,
    String? dataNascimento,
    int? genero,
    String? telefone,
    AddressModel? endereco,
    bool? aceitaTermos,
    bool? aceitaNotificacoes,
  }) {
    return UserModel(
      id: id ?? this.id,
      nomeCompleto: nomeCompleto ?? this.nomeCompleto,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      cns: cns ?? this.cns,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      genero: genero ?? this.genero,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      aceitaTermos: aceitaTermos ?? this.aceitaTermos,
      aceitaNotificacoes: aceitaNotificacoes ?? this.aceitaNotificacoes,
    );
  }
}