// lib/features/auth/presentation/controllers/register_controller.dart

import 'package:flutter/widgets.dart'; // Necessário para TextEditingController
import 'package:mobx/mobx.dart';
import 'dart:convert'; // Importado para usar jsonEncode na depuração

// Importe os datasources e as exceções da sua nova estrutura
import 'package:agenda_sus/features/address/data/datasources/viacep_datasource.dart';
import 'package:agenda_sus/features/auth/data/datasources/auth_datasource.dart'; // Novo import!
import 'package:agenda_sus/core/errors/exceptions.dart'; // Para lidar com as exceções

part 'register_controller.g.dart'; // O nome do arquivo .g.dart também mudou para refletir o nome da classe

class RegisterController = _RegisterController with _$RegisterController;

abstract class _RegisterController with Store {
  final ViaCepDatasource _viaCepDatasource;
  final AuthDatasource _authDatasource; // INJETADO: Agora o controller recebe o AuthDatasource

  // CONSTRUTOR: Recebe AMBAS as instâncias dos datasources
  _RegisterController(this._viaCepDatasource, this._authDatasource);

  @observable
  String nome = "";

  @observable
  String cpf = "";

  // Retorna o CPF apenas com dígitos (sem máscara)
  String get cpfSemMascara => cpf.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String cns = "";

  // Retorna o CNS apenas com dígitos (sem máscara)
  String get cnsSemMascara => cns.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String senha = "";

  @observable
  String confirmaSenha = "";

  @observable
  String dataNascimento = "";

  @observable
  String genero = "";

  @observable
  String email = "";

  @observable
  String confirmaEmail = "";

  @observable
  String telefone = "";

  // Retorna o Telefone apenas com dígitos (sem máscara)
  String get telefoneSemMascara => telefone.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String cep = "";

  // Retorna o CEP apenas com dígitos (sem máscara)
  String get cepSemMascara => cep.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String rua = "";

  @observable
  String numero = "";

  @observable
  String complemento = "";

  @observable
  String bairro = "";

  @observable
  String cidade = "";

  @observable
  String uf = "";

  @observable
  bool lgpd = false;

  @observable
  bool comunicacao = false;

  @computed
  bool get SenhasIguais => senha == confirmaSenha;

  @computed
  bool get emailsConferem => email == confirmaEmail;

  @computed
  bool get CEPValidado => cepSemMascara.length > 7;

  // Os TextEditingControllers para exibição dos dados do CEP
  TextEditingController get ruaController => TextEditingController(text: rua);
  TextEditingController get bairroController => TextEditingController(text: bairro);
  TextEditingController get cidadeController => TextEditingController(text: cidade);
  TextEditingController get ufController => TextEditingController(text: uf);

  @computed
  bool get lgpdConfirmado => lgpd;

  @computed
  bool get comunicacaoConfirmada => comunicacao;

  @action
  void setNome(String? value) {
    if (value != null) {
      nome = value.trim().split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    } else {
      nome = '';
    }
  }

  @action
  void setCPF(String? value) => cpf = value?.trim() ?? '';

  @action
  void setCNS(String? value) => cns = value?.trim() ?? '';

  @action
  void setSenha(String? value) => senha = value?.trim() ?? '';

  @action
  void setConfirmaSenha(String? value) => confirmaSenha = value?.trim() ?? '';

  @action
  void setDataNascimento(String? value) => dataNascimento = value?.trim() ?? '';

  @action
  void setGenero(String? value) => genero = value?.trim() ?? '';

  @action
  void setEmail(String? value) => email = value?.trim() ?? '';

  @action
  void setConfirmaEmail(String? value) => confirmaEmail = value?.trim() ?? '';

  @action
  void setTelefone(String? value) => telefone = value?.trim() ?? '';

  @action
  void setCEP(String? value) => cep = value?.trim() ?? '';

  @action
  void setRua(String? value) => rua = value?.trim() ?? '';

  @action
  void setNumero(String? value) => numero = value?.trim() ?? '';

  @action
  void setComplemento(String? value) => complemento = value?.trim() ?? '';

  @action
  void setBairro(String? value) => bairro = value?.trim() ?? '';

  @action
  void setCidade(String? value) => cidade = value?.trim() ?? '';

  @action
  void setUF(String? value) => uf = value?.trim() ?? '';

  @action
  bool setLGPD() => lgpd = !lgpd;

  @action
  bool setComunicacao() => comunicacao = !comunicacao;

  @action
  Future<void> buscarCep() async {
    if (CEPValidado) {
      try {
        final endereco = await _viaCepDatasource.buscarCep(cepSemMascara);
        print("Entrou na busca do CEP");
        runInAction(() {
          setRua(endereco.logradouro?.trim() ?? '');
          setBairro(endereco.bairro?.trim() ?? '');
          setCidade(endereco.localidade?.trim() ?? '');
          setUF(endereco.uf?.trim() ?? '');
        });
      } on AppExceptions catch (e) {
        print("Erro ao buscar CEP: ${e.message}");
        runInAction(() {
          setRua('');
          setBairro('');
          setCidade('');
          setUF('');
        });
        rethrow; // Relança para a UI poder capturar e exibir SnackBar
      } catch (e) {
        print("Erro inesperado ao buscar CEP: $e");
        runInAction(() {
          setRua('');
          setBairro('');
          setCidade('');
          setUF('');
        });
        rethrow; // Relança para a UI poder capturar
      }
    }
  }

  // >>> AÇÃO PARA CADASTRAR O USUÁRIO (AGORA COM CPF E CEP SEM MÁSCARA) <<<
  @action
  Future<void> cadastrarUsuario() async {
    // Construir o payload (Map) que o backend espera
    Map<String, dynamic> payload = {
      "nomeCompleto": nome,
      "cpf": cpfSemMascara, // <<<<< CORRIGIDO: Agora envia CPF SEM máscara >>>>>
      "cns": cnsSemMascara,
      "senha": senha,
      "dataNascimento": dataNascimento,
      "genero": genero == 'Feminino' ? 0 : 1, // 0 para Feminino, 1 para Masculino
      "email": email,
      "telefone": telefoneSemMascara,
      "endereco": {
        "cep": cepSemMascara, // <<<<< CORRIGIDO: Agora envia CEP SEM máscara >>>>>
        "rua": ruaController.text,
        "numero": numero,
        "complemento": complemento,
        "bairro": bairroController.text,
        "cidade": cidadeController.text,
        "uf": ufController.text
      },
      "aceitaTermos": lgpd,
      "aceitaNotificacoes": comunicacao,
    };

    // --- LINHAS PARA PRINTAR O JSON PREPARADO ---
    print('\n=== JSON PREPARADO PARA O BACKEND ===');
    print(jsonEncode(payload)); // Converte o Map para uma string JSON formatada e printa
    print('=====================================\n');
    // ---------------------------------------------

    try {
      // Chama o método registerUser do AuthDatasource
      await _authDatasource.registerUser(payload);
      print('Dados enviados para o backend com sucesso!');
    } on AppExceptions catch (e) {
      print('Erro de cadastro (AppException): ${e.message}');
      rethrow; // Relança a exceção para ser capturada na UI (RegisterPage)
    } catch (e) {
      print('Erro inesperado ao cadastrar usuário: $e');
      rethrow; // Relança qualquer outro erro inesperado
    }
  }
}