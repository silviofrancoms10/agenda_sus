import 'package:mobx/mobx.dart';

part 'sus_card_controller.g.dart';

class SusCardController = _SusCardController with _$SusCardController;

abstract class _SusCardController with Store {
  @observable
  String nome = "Nome Completo";
  @observable
  String numeroCartao = "000 0000 0000 0000";
  @observable
  String dataNascimento = "DD/MM/AAAA";
  @observable
  String sexo = "N/A";

  _SusCardController();

  @action
  void setCardData({
    required String nome,
    required String numeroCartao,
    required String dataNascimento,
    required String sexo,
  }) {
    this.nome = nome;
    this.numeroCartao = _formatCns(numeroCartao);
    this.dataNascimento = dataNascimento;
    this.sexo = sexo;
  }

  String _formatCns(String cns) {
    if (cns == null || cns.isEmpty) {
      return '';
    }
    String digitsOnly = cns.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != 15) {
      return cns; 
    }

    return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, 7)} ${digitsOnly.substring(7, 11)} ${digitsOnly.substring(11, 15)}';
  }
}