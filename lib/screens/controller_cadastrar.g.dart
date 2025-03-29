// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_cadastrar.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerCadastrar on _ControllerCadastrar, Store {
  Computed<bool>? _$CEPValidadoComputed;

  @override
  bool get CEPValidado =>
      (_$CEPValidadoComputed ??= Computed<bool>(() => super.CEPValidado,
              name: '_ControllerCadastrar.CEPValidado'))
          .value;

  late final _$nomeAtom =
      Atom(name: '_ControllerCadastrar.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$cpfAtom =
      Atom(name: '_ControllerCadastrar.cpf', context: context);

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  late final _$cnsAtom =
      Atom(name: '_ControllerCadastrar.cns', context: context);

  @override
  String get cns {
    _$cnsAtom.reportRead();
    return super.cns;
  }

  @override
  set cns(String value) {
    _$cnsAtom.reportWrite(value, super.cns, () {
      super.cns = value;
    });
  }

  late final _$dataNascimentoAtom =
      Atom(name: '_ControllerCadastrar.dataNascimento', context: context);

  @override
  String get dataNascimento {
    _$dataNascimentoAtom.reportRead();
    return super.dataNascimento;
  }

  @override
  set dataNascimento(String value) {
    _$dataNascimentoAtom.reportWrite(value, super.dataNascimento, () {
      super.dataNascimento = value;
    });
  }

  late final _$generoAtom =
      Atom(name: '_ControllerCadastrar.genero', context: context);

  @override
  String get genero {
    _$generoAtom.reportRead();
    return super.genero;
  }

  @override
  set genero(String value) {
    _$generoAtom.reportWrite(value, super.genero, () {
      super.genero = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_ControllerCadastrar.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$telefoneAtom =
      Atom(name: '_ControllerCadastrar.telefone', context: context);

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  late final _$cepAtom =
      Atom(name: '_ControllerCadastrar.cep', context: context);

  @override
  String get cep {
    _$cepAtom.reportRead();
    return super.cep;
  }

  @override
  set cep(String value) {
    _$cepAtom.reportWrite(value, super.cep, () {
      super.cep = value;
    });
  }

  late final _$ruaAtom =
      Atom(name: '_ControllerCadastrar.rua', context: context);

  @override
  String get rua {
    _$ruaAtom.reportRead();
    return super.rua;
  }

  @override
  set rua(String value) {
    _$ruaAtom.reportWrite(value, super.rua, () {
      super.rua = value;
    });
  }

  late final _$numeroAtom =
      Atom(name: '_ControllerCadastrar.numero', context: context);

  @override
  String get numero {
    _$numeroAtom.reportRead();
    return super.numero;
  }

  @override
  set numero(String value) {
    _$numeroAtom.reportWrite(value, super.numero, () {
      super.numero = value;
    });
  }

  late final _$complementoAtom =
      Atom(name: '_ControllerCadastrar.complemento', context: context);

  @override
  String get complemento {
    _$complementoAtom.reportRead();
    return super.complemento;
  }

  @override
  set complemento(String value) {
    _$complementoAtom.reportWrite(value, super.complemento, () {
      super.complemento = value;
    });
  }

  late final _$bairroAtom =
      Atom(name: '_ControllerCadastrar.bairro', context: context);

  @override
  String get bairro {
    _$bairroAtom.reportRead();
    return super.bairro;
  }

  @override
  set bairro(String value) {
    _$bairroAtom.reportWrite(value, super.bairro, () {
      super.bairro = value;
    });
  }

  late final _$cidadeAtom =
      Atom(name: '_ControllerCadastrar.cidade', context: context);

  @override
  String get cidade {
    _$cidadeAtom.reportRead();
    return super.cidade;
  }

  @override
  set cidade(String value) {
    _$cidadeAtom.reportWrite(value, super.cidade, () {
      super.cidade = value;
    });
  }

  late final _$ufAtom = Atom(name: '_ControllerCadastrar.uf', context: context);

  @override
  String get uf {
    _$ufAtom.reportRead();
    return super.uf;
  }

  @override
  set uf(String value) {
    _$ufAtom.reportWrite(value, super.uf, () {
      super.uf = value;
    });
  }

  late final _$buscarCepAsyncAction =
      AsyncAction('_ControllerCadastrar.buscarCep', context: context);

  @override
  Future<void> buscarCep() {
    return _$buscarCepAsyncAction.run(() => super.buscarCep());
  }

  late final _$_ControllerCadastrarActionController =
      ActionController(name: '_ControllerCadastrar', context: context);

  @override
  void setNome(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCPF(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setCPF');
    try {
      return super.setCPF(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCNS(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setCNS');
    try {
      return super.setCNS(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataNascimento(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setDataNascimento');
    try {
      return super.setDataNascimento(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGenero(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setGenero');
    try {
      return super.setGenero(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTelefone(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setTelefone');
    try {
      return super.setTelefone(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCEP(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setCEP');
    try {
      return super.setCEP(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRua(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setRua');
    try {
      return super.setRua(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumero(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setNumero');
    try {
      return super.setNumero(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComplemento(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setComplemento');
    try {
      return super.setComplemento(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBairro(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setBairro');
    try {
      return super.setBairro(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCidade(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setCidade');
    try {
      return super.setCidade(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUF(dynamic value) {
    final _$actionInfo = _$_ControllerCadastrarActionController.startAction(
        name: '_ControllerCadastrar.setUF');
    try {
      return super.setUF(value);
    } finally {
      _$_ControllerCadastrarActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
cpf: ${cpf},
cns: ${cns},
dataNascimento: ${dataNascimento},
genero: ${genero},
email: ${email},
telefone: ${telefone},
cep: ${cep},
rua: ${rua},
numero: ${numero},
complemento: ${complemento},
bairro: ${bairro},
cidade: ${cidade},
uf: ${uf},
CEPValidado: ${CEPValidado}
    ''';
  }
}
