// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sus_card_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SusCardController on _SusCardController, Store {
  late final _$nomeAtom =
      Atom(name: '_SusCardController.nome', context: context);

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

  late final _$numeroCartaoAtom =
      Atom(name: '_SusCardController.numeroCartao', context: context);

  @override
  String get numeroCartao {
    _$numeroCartaoAtom.reportRead();
    return super.numeroCartao;
  }

  @override
  set numeroCartao(String value) {
    _$numeroCartaoAtom.reportWrite(value, super.numeroCartao, () {
      super.numeroCartao = value;
    });
  }

  late final _$dataNascimentoAtom =
      Atom(name: '_SusCardController.dataNascimento', context: context);

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

  late final _$sexoAtom =
      Atom(name: '_SusCardController.sexo', context: context);

  @override
  String get sexo {
    _$sexoAtom.reportRead();
    return super.sexo;
  }

  @override
  set sexo(String value) {
    _$sexoAtom.reportWrite(value, super.sexo, () {
      super.sexo = value;
    });
  }

  late final _$_SusCardControllerActionController =
      ActionController(name: '_SusCardController', context: context);

  @override
  void setCardData(
      {required String nome,
      required String numeroCartao,
      required String dataNascimento,
      required String sexo}) {
    final _$actionInfo = _$_SusCardControllerActionController.startAction(
        name: '_SusCardController.setCardData');
    try {
      return super.setCardData(
          nome: nome,
          numeroCartao: numeroCartao,
          dataNascimento: dataNascimento,
          sexo: sexo);
    } finally {
      _$_SusCardControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
numeroCartao: ${numeroCartao},
dataNascimento: ${dataNascimento},
sexo: ${sexo}
    ''';
  }
}
