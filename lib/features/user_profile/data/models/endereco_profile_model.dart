class EnderecoProfileModel {
  final int? id;
  final String? cep;
  final String? rua;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? cidade;
  final String? uf;

  const EnderecoProfileModel({
    this.id,
    this.cep,
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
  });

  factory EnderecoProfileModel.fromJson(Map<String, dynamic> json) {
    return EnderecoProfileModel(
      id: (json['id'] as num?)?.toInt(),
      cep: json['cep'] as String?,
      rua: json['logradouro'] as String?,
      numero: json['numero'] as String?,
      complemento: json['complemento'] as String?,
      bairro: json['bairro'] as String?,
      cidade: json['localidade'] as String?,
      uf: json['uf'] as String?,
    );
  }
}
