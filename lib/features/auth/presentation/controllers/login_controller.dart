import 'package:mobx/mobx.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/features/auth/data/datasources/auth_datasource.dart';
import 'package:agenda_sus/features/auth/data/models/login_response_model.dart';
import 'package:agenda_sus/features/auth/data/models/user_model.dart';
import 'package:agenda_sus/features/address/data/models/address_model.dart';
import 'package:agenda_sus/core/network/dio_client.dart'; // Importar DioClient para configurar o token

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  final AuthDatasource _authDatasource;
  final DioClient _dioClient;

  _LoginController(this._authDatasource, this._dioClient);

  @observable
  String email = "";
  @observable
  String senha = "";
  @observable
  bool carregando = false;
  @observable
  UserModel? usuarioAtual;
  @observable
  String? tokenAtual;

  @computed
  bool get isFormValid => email.isNotEmpty && senha.length >= 8;
  @computed
  bool get usuarioLogado => usuarioAtual != null;

  @action
  void setEmail(String? value) {
    email = value?.trim() ?? '';
  }
  @action
  void setSenha(String? value) {
    senha = value?.trim() ?? '';
  }

  @action
  Future<void> logar() async {
    carregando = true;
    usuarioAtual = null;

    try {
      final LoginResponseModel loginResponse = await _authDatasource.loginUser(email: email, senha: senha);
      
      _dioClient.setAuthorizationHeader(loginResponse.token);
      tokenAtual = loginResponse.token;

      // Buscar os dados completos do usuário após o login
      final UserModel userCompleto = await _authDatasource.getUserById(loginResponse.userId);

      runInAction(() {
        usuarioAtual = userCompleto;
      });

    } on ServerException catch (e) {
      if (e.statusCode == 401) {
        throw ServerException(message: 'E-mail ou senha incorretos.', statusCode: e.statusCode);
      } else {
        rethrow;
      }
    } catch (e) {
      print('❌ ERRO NO LOGIN: $e');
      rethrow;
    } finally {
      runInAction(() {
        carregando = false;
      });
    }
  }
}