// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginController, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_LoginController.isFormValid'))
          .value;
  Computed<bool>? _$usuarioLogadoComputed;

  @override
  bool get usuarioLogado =>
      (_$usuarioLogadoComputed ??= Computed<bool>(() => super.usuarioLogado,
              name: '_LoginController.usuarioLogado'))
          .value;

  late final _$emailAtom =
      Atom(name: '_LoginController.email', context: context);

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

  late final _$senhaAtom =
      Atom(name: '_LoginController.senha', context: context);

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

  late final _$carregandoAtom =
      Atom(name: '_LoginController.carregando', context: context);

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

  late final _$usuarioAtualAtom =
      Atom(name: '_LoginController.usuarioAtual', context: context);

  @override
  UserModel? get usuarioAtual {
    _$usuarioAtualAtom.reportRead();
    return super.usuarioAtual;
  }

  @override
  set usuarioAtual(UserModel? value) {
    _$usuarioAtualAtom.reportWrite(value, super.usuarioAtual, () {
      super.usuarioAtual = value;
    });
  }

  late final _$tokenAtualAtom =
      Atom(name: '_LoginController.tokenAtual', context: context);

  @override
  String? get tokenAtual {
    _$tokenAtualAtom.reportRead();
    return super.tokenAtual;
  }

  @override
  set tokenAtual(String? value) {
    _$tokenAtualAtom.reportWrite(value, super.tokenAtual, () {
      super.tokenAtual = value;
    });
  }

  late final _$logarAsyncAction =
      AsyncAction('_LoginController.logar', context: context);

  @override
  Future<void> logar() {
    return _$logarAsyncAction.run(() => super.logar());
  }

  late final _$_LoginControllerActionController =
      ActionController(name: '_LoginController', context: context);

  @override
  void setEmail(String? value) {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
        name: '_LoginController.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(String? value) {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
        name: '_LoginController.setSenha');
    try {
      return super.setSenha(value);
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
senha: ${senha},
carregando: ${carregando},
usuarioAtual: ${usuarioAtual},
tokenAtual: ${tokenAtual},
isFormValid: ${isFormValid},
usuarioLogado: ${usuarioLogado}
    ''';
  }
}
