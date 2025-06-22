import 'package:dio/dio.dart';
import 'package:agenda_sus/core/network/dio_client.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/features/auth/data/models/login_response_model.dart';
import 'package:agenda_sus/features/auth/data/models/user_model.dart';


abstract class AuthDatasource {
  Future<void> registerUser(Map<String, dynamic> userData);
  
  Future<LoginResponseModel> loginUser({required String email, required String senha});

  Future<UserModel> getUserById(int id);
}


class AuthDatasourceImpl implements AuthDatasource {
  final DioClient _dioClient;
  AuthDatasourceImpl(this._dioClient);

  @override
  Future<LoginResponseModel> loginUser({required String email, required String senha}) async {
    try {
      print('🔍 TENTANDO LOGIN: $email');
      print('🌐 TENTANDO API REAL...');
      
      final loginData = {'email': email, 'senha': senha};
      
      final response = await _dioClient.dio.post('/auth/login', data: loginData);
      
      print('✅ API RESPONDEU: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        _dioClient.setAuthorizationHeader(loginResponse.token);
        return loginResponse;
      } else {
        throw ServerException(
          message: 'Falha no login com status ${response.statusCode}.',
          statusCode: response.statusCode,
        );
      }

    } on DioException catch (e) {
      print('❌ ERRO API: ${e.message}');
      print('📊 STATUS: ${e.response?.statusCode}');
      print('📄 DADOS: ${e.response?.data}');
      
      if (e.response?.statusCode == 401) {
        throw ServerException(
          message: 'E-mail ou senha incorretos.',
          statusCode: 401,
        );
      } else if (e.response?.statusCode == 400) {
        final errorMessage = e.response?.data['message'] ?? 'Dados inválidos. Verifique as informações fornecidas.';
        throw ServerException(
          message: errorMessage,
          statusCode: 400,
        );
      } else if (e.response?.statusCode == 404) {
        throw ServerException(
          message: 'Usuário não encontrado. Verifique se o e-mail está correto.',
          statusCode: 404,
        );
      } else if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(
          message: 'Erro de conexão. Verifique sua internet e tente novamente.',
          statusCode: null,
        );
      } else {
        final errorMessage = e.response?.data['message'] ?? 'Erro ao fazer login. Tente novamente.';
        throw ServerException(
          message: errorMessage,
          statusCode: e.response?.statusCode,
        );
      }
    } catch (e) {
      print('❌ ERRO GERAL: $e');
      throw GenericException(message: 'Ocorreu um erro inesperado: $e');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await _dioClient.dio.get('/usuarios/$id');
      print('>>> RESPOSTA CRUA DA API /usuarios/$id: ${response.data}');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Falha ao buscar dados do usuário',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      print('❌ ERRO AO BUSCAR USUÁRIO: ${e.message}');
      print('📊 STATUS: ${e.response?.statusCode}');
      print('📄 DADOS: ${e.response?.data}');
      throw ServerException(
        message: 'Erro de rede ao buscar dados do usuário.',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      print('❌ ERRO GERAL AO BUSCAR USUÁRIO: $e');
      throw GenericException(message: 'Ocorreu um erro ao buscar dados do usuário.');
    }
  }

  @override
  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      await _dioClient.dio.post('/usuarios', data: userData);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Erro ao cadastrar usuário';
      throw ServerException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw GenericException(message: 'Ocorreu um erro inesperado no cadastro.');
    }
  }
}