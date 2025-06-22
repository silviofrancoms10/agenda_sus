import 'package:mobx/mobx.dart';

part 'main_app_controller.g.dart';

class MainAppController = _MainAppController with _$MainAppController;

abstract class _MainAppController with Store {
  @observable
  int indiceAtual = 0;

  _MainAppController();

  @action
  void setIndiceAtual(int indice) {
    indiceAtual = indice;
  }
}
