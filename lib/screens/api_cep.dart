import 'package:agenda_sus/screens/endereco.dart';
import 'package:dio/dio.dart';

const urlBase = 'https://viacep.com.br/ws/';
const sufixo = '/json/';

class ApiCep {
  Future<Endereco> buscarCep(String cepInformado) async {
    try {
      // Remove caracteres não numéricos do CEP
      final cepLimpo = cepInformado.replaceAll(RegExp(r'[^0-9]'), '');
      
      // Verifica se o CEP tem 8 dígitos
      if (cepLimpo.length != 8) {
        throw Exception('CEP deve conter 8 dígitos');
      }

      final response = await Dio().get('$urlBase$cepLimpo$sufixo');

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar CEP: ${response.statusCode}');
      }

      // Converte diretamente o response.data para Endereco
      return Endereco.fromJson(response.data);
    } catch (e) {
      print('Erro na busca do CEP: $e');
      throw Exception('Não foi possível buscar o CEP: $e');
    }
  }
}