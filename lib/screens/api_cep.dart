import 'package:agenda_sus/screens/endereco.dart';
import 'package:dio/dio.dart';

const urlBase = 'https://viacep.com.br/ws/';
const sufixo = '/json/';

class ApiCep {
  Future<Endereco> buscarCep(String cepInformado) async {
    try {

      if (cepInformado.length < 8) {
        throw FormatException('CEP deve conter 8 dígitos');
      }

      final response = await Dio().get(
        '$urlBase$cepInformado$sufixo',
        options: Options(receiveTimeout: const Duration(seconds: 15)),
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar CEP: ${response.statusCode}');
      }

      // Converte diretamente o response.data para Endereco
      return Endereco.fromJson(response.data);
    } catch (e) {
      throw Exception('Não foi possível buscar o CEP: $e');
    }
  }
}
