// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeController, Store {
  late final _$nomeExibicaoAtom =
      Atom(name: '_HomeController.nomeExibicao', context: context);

  @override
  String get nomeExibicao {
    _$nomeExibicaoAtom.reportRead();
    return super.nomeExibicao;
  }

  @override
  set nomeExibicao(String value) {
    _$nomeExibicaoAtom.reportWrite(value, super.nomeExibicao, () {
      super.nomeExibicao = value;
    });
  }

  late final _$avisosAtom =
      Atom(name: '_HomeController.avisos', context: context);

  @override
  ObservableList<String> get avisos {
    _$avisosAtom.reportRead();
    return super.avisos;
  }

  @override
  set avisos(ObservableList<String> value) {
    _$avisosAtom.reportWrite(value, super.avisos, () {
      super.avisos = value;
    });
  }

  late final _$proximasConsultasAtom =
      Atom(name: '_HomeController.proximasConsultas', context: context);

  @override
  ObservableList<Map<String, String>> get proximasConsultas {
    _$proximasConsultasAtom.reportRead();
    return super.proximasConsultas;
  }

  @override
  set proximasConsultas(ObservableList<Map<String, String>> value) {
    _$proximasConsultasAtom.reportWrite(value, super.proximasConsultas, () {
      super.proximasConsultas = value;
    });
  }

  late final _$_HomeControllerActionController =
      ActionController(name: '_HomeController', context: context);

  @override
  void setNomeUsuario(String nome) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.setNomeUsuario');
    try {
      return super.setNomeUsuario(nome);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _loadMockData() {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController._loadMockData');
    try {
      return super._loadMockData();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nomeExibicao: ${nomeExibicao},
avisos: ${avisos},
proximasConsultas: ${proximasConsultas}
    ''';
  }
}
