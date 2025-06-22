import 'package:dio/dio.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/core/network/dio_client.dart';
import 'package:agenda_sus/features/address/data/models/address_model.dart';

class ViaCepDatasource {
  final DioClient _dioClient;

  ViaCepDatasource(this._dioClient);

  Future<AddressModel> buscarCep(String cepInformado) async {
    try {
      if (cepInformado.length < 8) {
        throw InvalidInputException(
          message: 'CEP deve conter 8 dígitos.',
          code: 'CEP_INVALID_LENGTH',
        );
      }

      final response = await _dioClient.dio.get(
        'https://viacep.com.br/ws/$cepInformado/json/',
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Erro ao buscar CEP: Código ${response.statusCode}.',
          statusCode: response.statusCode,
        );
      }

      final Map<String, dynamic> data = response.data;
      if (data.containsKey('erro') && data['erro'] == true) {
        throw ServerException(
          message: 'CEP não encontrado ou inválido na base de dados do ViaCEP.',
          statusCode: response.statusCode,
        );
      }

      return AddressModel.fromJson(data);
    } on DioException catch (e) {
      String errorMessage = 'Ocorreu um erro na conexão ao buscar CEP.';
      int? statusCode;

      if (e.response != null) {
        statusCode = e.response!.statusCode;
        if (e.response!.data != null && e.response!.data is Map && e.response!.data.containsKey('message')) {
          errorMessage = e.response!.data['message'];
        } else if (e.response!.data != null) {
          errorMessage = e.response!.data.toString();
        }
        throw ServerException(
          message: 'Erro do servidor ao buscar CEP: $errorMessage',
          statusCode: statusCode,
        );
      } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException(
          message: 'Tempo limite esgotado ao buscar CEP. Verifique sua internet.',
          statusCode: statusCode,
        );
      } else if (e.type == DioExceptionType.badResponse) {
        throw ServerException(
          message: 'Resposta inválida do servidor: ${e.response?.statusCode}.',
          statusCode: e.response?.statusCode,
        );
      } else if (e.type == DioExceptionType.unknown) {
        throw NetworkException(
          message: 'Verifique sua conexão com a internet ou o endereço do serviço.',
          statusCode: statusCode,
        );
      } else {
        throw NetworkException(
          message: 'Erro de rede inesperado ao buscar CEP: ${e.message}',
          statusCode: statusCode,
        );
      }
    } catch (e) {
      if (e is InvalidInputException) {
        rethrow;
      }
      throw GenericException(
        message: 'Não foi possível buscar o CEP devido a um erro inesperado: ${e.toString()}',
      );
    }
  }
}
