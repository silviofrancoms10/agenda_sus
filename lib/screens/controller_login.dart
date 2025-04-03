import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
part 'controller_login.g.dart';

class ControllerLogin = _ControllerLogin with _$ControllerLogin;

abstract class _ControllerLogin with Store {
  @observable
  String cpf = '';

  @observable
  String senha = '';

  @observable
  bool usuarioLogado = false;

  @observable
  bool carregando = false;

  String get cpfSemMascara => cpf.replaceAll(RegExp(r'[^0-9]'), '');

  TextEditingController get controllerCpf => TextEditingController(text: cpf);

  TextEditingController get controllerSenha =>
      TextEditingController(text: senha);

  @action
  void setCpf(value) => cpf = value;

  @action
  void setSenha(value) => senha = value;

  @computed
  bool get isValid => cpf.length > 10 && senha.length >= 6;

  @action
  Future<void> logar() async {
    carregando = true;
    print('$cpfSemMascara - $senha - $isValid');
    await Future.delayed(const Duration(seconds: 2)); // Simula uma requisição
    carregando = false;
    usuarioLogado = true;
  }
}
