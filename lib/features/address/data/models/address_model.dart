// lib/features/address/data/models/address_model.dart

class AddressModel {
  final int? id;
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? unidade;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;

  const AddressModel({
    this.id,
    this.cep,
    this.logradouro,
    this.complemento,
    this.unidade,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: (json['id'] as num?)?.toInt(),
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? json['rua'] ?? '',
      complemento: json['complemento'] ?? '',
      unidade: json['unidade'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? json['cidade'] ?? '',
      uf: json['uf'] ?? '',
      ibge: json['ibge'] ?? '',
      gia: json['gia'] ?? '',
      ddd: json['ddd'] ?? '',
      siafi: json['siafi'] ?? '',
    );
  }

  // --- MÉTODO copyWith ADICIONADO AQUI ---
  AddressModel copyWith({
    int? id,
    String? cep,
    String? logradouro,
    String? complemento,
    String? unidade,
    String? bairro,
    String? localidade,
    String? uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  }) {
    return AddressModel(
      id: id ?? this.id,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      complemento: complemento ?? this.complemento,
      unidade: unidade ?? this.unidade,
      bairro: bairro ?? this.bairro,
      localidade: localidade ?? this.localidade,
      uf: uf ?? this.uf,
      ibge: ibge ?? this.ibge,
      gia: gia ?? this.gia,
      ddd: ddd ?? this.ddd,
      siafi: siafi ?? this.siafi,
    );
  }
  // ------------------------------------

  @override
  String toString() {
    return 'AddressModel{id: $id, cep: $cep, logradouro: $logradouro, bairro: $bairro, localidade: $localidade, uf: $uf}';
  }
}