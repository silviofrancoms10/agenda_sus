// lib/features/user_profile/data/datasources/user_profile_datasource.dart

import 'package:dio/dio.dart';
import 'package:agenda_sus/core/network/dio_client.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/features/auth/data/models/user_model.dart';
import 'package:agenda_sus/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileDatasource {
  Future<UserModel> getUserProfile(int userId);
  Future<void> updateUserProfile(UserProfileModel userProfile);
}

class UserProfileDatasourceImpl implements UserProfileDatasource {
  final DioClient _dioClient;

  UserProfileDatasourceImpl(this._dioClient);

  @override
  Future<UserModel> getUserProfile(int userId) async {
    try {
      final response = await _dioClient.dio.get('/usuarios/$userId');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Falha ao carregar perfil do usuário. Código: ${response.statusCode}.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Erro no servidor ao carregar perfil.';
        throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
      } else {
        throw NetworkException(message: 'Erro de conexão ao carregar perfil. Verifique sua internet.');
      }
    } catch (e) {
      throw GenericException(message: 'Erro inesperado ao carregar perfil: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUserProfile(UserProfileModel userProfile) async {
    try {
      final Map<String, dynamic> payload = {
        "id": userProfile.id,
        "nomeCompleto": userProfile.nomeCompleto,
        "cpf": userProfile.cpf,
        "cns": userProfile.cns,
        "senha": userProfile.senha, // AGORA ESTE CAMPO SERÁ ENVIADO SE NÃO FOR NULL
        "dataNascimento": userProfile.dataNascimento,
        "genero": userProfile.genero,
        "email": userProfile.email,
        "telefone": userProfile.telefone,
        "endereco": {
          "id": userProfile.endereco?.id,
          "cep": userProfile.endereco?.cep,
          "rua": userProfile.endereco?.rua,
          "numero": userProfile.endereco?.numero,
          "complemento": userProfile.endereco?.complemento,
          "bairro": userProfile.endereco?.bairro,
          "cidade": userProfile.endereco?.cidade,
          "uf": userProfile.endereco?.uf
        },
        "aceitaTermos": userProfile.aceitaTermos,
        "aceitaNotificacoes": userProfile.aceitaNotificacoes,
      };

      print('Payload de atualização de perfil enviado para /usuarios/${userProfile.id}: $payload');

      await _dioClient.dio.put('/usuarios', data: payload);
      print('Perfil atualizado com sucesso!');
    } on DioException catch (e) {
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Erro no servidor ao atualizar perfil.';
        throw ServerException(message: errorMessage, statusCode: e.response?.statusCode);
      } else {
        throw NetworkException(message: 'Erro de conexão ao atualizar perfil. Verifique sua internet.');
      }
    } catch (e) {
      throw GenericException(message: 'Erro inesperado ao atualizar perfil: ${e.toString()}');
    }
  }
}