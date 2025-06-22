// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainAppController on _MainAppController, Store {
  late final _$indiceAtualAtom =
      Atom(name: '_MainAppController.indiceAtual', context: context);

  @override
  int get indiceAtual {
    _$indiceAtualAtom.reportRead();
    return super.indiceAtual;
  }

  @override
  set indiceAtual(int value) {
    _$indiceAtualAtom.reportWrite(value, super.indiceAtual, () {
      super.indiceAtual = value;
    });
  }

  late final _$_MainAppControllerActionController =
      ActionController(name: '_MainAppController', context: context);

  @override
  void setIndiceAtual(int indice) {
    final _$actionInfo = _$_MainAppControllerActionController.startAction(
        name: '_MainAppController.setIndiceAtual');
    try {
      return super.setIndiceAtual(indice);
    } finally {
      _$_MainAppControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
indiceAtual: ${indiceAtual}
    ''';
  }
}
