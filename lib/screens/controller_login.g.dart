// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerLogin on _ControllerLogin, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_ControllerLogin.isValid'))
      .value;

  late final _$cpfAtom = Atom(name: '_ControllerLogin.cpf', context: context);

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

  late final _$senhaAtom =
      Atom(name: '_ControllerLogin.senha', context: context);

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  late final _$usuarioLogadoAtom =
      Atom(name: '_ControllerLogin.usuarioLogado', context: context);

  @override
  bool get usuarioLogado {
    _$usuarioLogadoAtom.reportRead();
    return super.usuarioLogado;
  }

  @override
  set usuarioLogado(bool value) {
    _$usuarioLogadoAtom.reportWrite(value, super.usuarioLogado, () {
      super.usuarioLogado = value;
    });
  }

  late final _$carregandoAtom =
      Atom(name: '_ControllerLogin.carregando', context: context);

  @override
  bool get carregando {
    _$carregandoAtom.reportRead();
    return super.carregando;
  }

  @override
  set carregando(bool value) {
    _$carregandoAtom.reportWrite(value, super.carregando, () {
      super.carregando = value;
    });
  }

  late final _$logarAsyncAction =
      AsyncAction('_ControllerLogin.logar', context: context);

  @override
  Future<void> logar() {
    return _$logarAsyncAction.run(() => super.logar());
  }

  late final _$_ControllerLoginActionController =
      ActionController(name: '_ControllerLogin', context: context);

  @override
  void setCpf(dynamic value) {
    final _$actionInfo = _$_ControllerLoginActionController.startAction(
        name: '_ControllerLogin.setCpf');
    try {
      return super.setCpf(value);
    } finally {
      _$_ControllerLoginActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(dynamic value) {
    final _$actionInfo = _$_ControllerLoginActionController.startAction(
        name: '_ControllerLogin.setSenha');
    try {
      return super.setSenha(value);
    } finally {
      _$_ControllerLoginActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cpf: ${cpf},
senha: ${senha},
usuarioLogado: ${usuarioLogado},
carregando: ${carregando},
isValid: ${isValid}
    ''';
  }
}
