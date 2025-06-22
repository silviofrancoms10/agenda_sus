// lib/features/user_profile/presentation/controllers/user_profile_controller.dart

import 'package:agenda_sus/features/user_profile/data/models/endereco_profile_model.dart';
import 'package:mobx/mobx.dart';

import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/features/user_profile/data/datasources/user_profile_datasource.dart';
import 'package:agenda_sus/features/auth/data/models/user_model.dart';
import 'package:agenda_sus/features/user_profile/data/models/user_profile_model.dart';
import 'package:agenda_sus/features/address/data/datasources/viacep_datasource.dart';

part 'user_profile_controller.g.dart';

class UserProfileController = _UserProfileController with _$UserProfileController;

abstract class _UserProfileController with Store {
  final UserProfileDatasource _userProfileDatasource;
  final ViaCepDatasource _viaCepDatasource;
  UserModel? _originalUser;

  _UserProfileController(this._userProfileDatasource, this._viaCepDatasource);

  @observable
  bool carregando = false;

  @observable
  String nome = "";
  @observable
  String cpf = "";
  String get cpfSemMascara => cpf.replaceAll(RegExp(r'\D'), '');
  @observable
  String cns = "";
  String get cnsSemMascara => cns.replaceAll(RegExp(r'\D'), '');
  @observable
  String dataNascimento = "";
  @observable
  String genero = "";
  @observable
  String email = "";
  @observable
  String telefone = "";
  String get telefoneSemMascara => telefone.replaceAll(RegExp(r'\D'), '');
  @observable
  String cep = "";
  String get cepSemMascara => cep.replaceAll(RegExp(r'\D'), '');
  @observable
  String rua = "";
  @observable
  String numero = "";
  @observable
  String complemento = ""; // Este campo é do usuário, não do ViaCEP
  @observable
  String bairro = "";
  @observable
  String cidade = "";
  @observable
  String uf = "";
  @observable
  bool aceitaTermos = false;
  @observable
  bool aceitaNotificacoes = false;

  @observable
  String novaSenha = "";
  @observable
  String confirmaNovaSenha = "";

  @computed
  bool get senhasConferem => novaSenha == confirmaNovaSenha;

  int? userId;
  int? enderecoId;


  @computed
  bool get CEPValidado => cepSemMascara.length == 8;

  @action
  Future<void> carregarPerfil(int idDoUsuario) async {
    if (carregando) return;

    carregando = true;
    userId = idDoUsuario;

    try {
      final UserModel user = await _userProfileDatasource.getUserProfile(idDoUsuario);
      
      _originalUser = user.copyWith(); 
      nome = user.nomeCompleto;
      cpf = user.cpf;
      cns = user.cns;
      dataNascimento = user.dataNascimento;
      genero = user.genero == 0 ? 'Feminino' : 'Masculino';
      email = user.email;
      telefone = user.telefone ?? '';
      
      enderecoId = user.endereco.id;
      cep = user.endereco.cep ?? '';
      rua = user.endereco.logradouro ?? '';
      numero = user.endereco.complemento ?? '';
      complemento = user.endereco.complemento ?? ''; // Preenche do backend, não do ViaCEP
      bairro = user.endereco.bairro ?? '';
      cidade = user.endereco.localidade ?? '';
      uf = user.endereco.uf ?? '';

      aceitaTermos = user.aceitaTermos ?? false;
      aceitaNotificacoes = user.aceitaNotificacoes ?? false;

      novaSenha = '';
      confirmaNovaSenha = '';

    } on AppExceptions catch (e) {
      _clearUserData();
      rethrow;
    } catch (e) {
      _clearUserData();
      throw GenericException(message: 'Erro inesperado ao carregar perfil: ${e.toString()}');
    } finally {
      carregando = false;
    }
  }

  @action
  void _clearUserData() {
    _originalUser = null;
    userId = null;
    nome = ""; cpf = ""; cns = ""; dataNascimento = ""; genero = "";
    email = ""; telefone = ""; cep = ""; rua = ""; numero = "";
    complemento = ""; bairro = ""; cidade = ""; uf = "";
    aceitaTermos = false; aceitaNotificacoes = false;
    novaSenha = ""; confirmaNovaSenha = "";
    enderecoId = null;
  }

  @computed
  bool get dadosAlterados {
    if (_originalUser == null) return false;

    if (nome != _originalUser!.nomeCompleto) return true;
    if (cpf != _originalUser!.cpf) return true;
    if (cns != _originalUser!.cns) return true;
    if (dataNascimento != _originalUser!.dataNascimento) return true;
    if ((genero == 'Feminino' ? 0 : 1) != _originalUser!.genero) return true;
    if (email != _originalUser!.email) return true;
    if (telefoneSemMascara != (_originalUser!.telefone?.replaceAll(RegExp(r'\D'), '') ?? '')) return true;
    if (aceitaTermos != (_originalUser!.aceitaTermos ?? false)) return true;
    if (aceitaNotificacoes != (_originalUser!.aceitaNotificacoes ?? false)) return true;

    if (cep != _originalUser!.endereco.cep) return true;
    if (rua != _originalUser!.endereco.logradouro) return true;
    if (numero != (_originalUser!.endereco.complemento ?? '')) return true;
    if (complemento != (_originalUser!.endereco.complemento ?? '')) return true; // Comparar o complemento
    if (bairro != _originalUser!.endereco.bairro) return true;
    if (cidade != _originalUser!.endereco.localidade) return true;
    if (uf != _originalUser!.endereco.uf) return true;

    return false;
  }

  @action
  void setNome(String? value) { nome = value?.trim() ?? ''; }
  @action
  void setCPF(String? value) => cpf = value?.trim() ?? '';
  @action
  void setCNS(String? value) => cns = value?.trim() ?? '';
  @action
  void setDataNascimento(String? value) => dataNascimento = value?.trim() ?? '';
  @action
  void setGenero(String? value) => genero = value?.trim() ?? '';
  @action
  void setEmail(String? value) => email = value?.trim() ?? '';
  @action
  void setTelefone(String? value) => telefone = value?.trim() ?? '';
  @action
  void setCEP(String? value) => cep = value?.trim() ?? '';
  @action
  void setRua(String? value) { rua = value?.trim() ?? ''; }
  @action
  void setNumero(String? value) => numero = value?.trim() ?? '';
  @action
  void setComplemento(String? value) => complemento = value?.trim() ?? '';
  @action
  void setBairro(String? value) { bairro = value?.trim() ?? ''; }
  @action
  void setCidade(String? value) { cidade = value?.trim() ?? ''; }
  @action
  void setUF(String? value) { uf = value?.trim() ?? ''; }
  @action
  void setAceitaTermos(bool value) => aceitaTermos = value;
  @action
  void setAceitaNotificacoes(bool value) => aceitaNotificacoes = value;

  @action
  void setNovaSenha(String? value) => novaSenha = value?.trim() ?? '';
  @action
  void setConfirmaNovaSenha(String? value) => confirmaNovaSenha = value?.trim() ?? '';

  @action
  Future<void> buscarCep() async {
    if (CEPValidado) {
      carregando = true;
      try {
        final endereco = await _viaCepDatasource.buscarCep(cepSemMascara);
        runInAction(() {
          setRua(endereco.logradouro ?? '');
          setBairro(endereco.bairro ?? '');
          setCidade(endereco.localidade ?? '');
          setUF(endereco.uf ?? '');
          // REMOVIDO: Não preenche o complemento com dado do ViaCEP
          // setComplemento(endereco.complemento ?? '');
        });
      } on AppExceptions catch (e) {
        runInAction(() {
          setRua(''); setBairro(''); setCidade(''); setUF(''); // Complemento não é limpo aqui
        });
        rethrow;
      } catch (e) {
        runInAction(() {
          setRua(''); setBairro(''); setCidade(''); setUF(''); // Complemento não é limpo aqui
        });
        throw GenericException(message: 'Erro inesperado ao buscar CEP: ${e.toString()}');
      } finally {
        carregando = false;
      }
    }
  }

  @action
  Future<void> atualizarPerfil() async {
    if (!dadosAlterados && novaSenha.isEmpty) {
      print('Nenhum dado alterado para salvar.');
      return;
    }

    carregando = true;
    try {
      if (userId == null) {
        throw GenericException(message: "ID do usuário não disponível para atualização.");
      }

      if (novaSenha.isNotEmpty) {
        if (novaSenha.length < 8) {
          throw InvalidInputException(message: 'A nova senha deve ter 8 dígitos ou mais.');
        }
        if (!senhasConferem) {
          throw InvalidInputException(message: 'As novas senhas não coincidem.');
        }
      }

      final UserProfileModel updatedProfile = UserProfileModel(
        id: userId,
        nomeCompleto: nome,
        cpf: cpf,
        cns: cnsSemMascara,
        senha: novaSenha.isNotEmpty ? novaSenha : null,
        dataNascimento: dataNascimento,
        genero: genero == 'Feminino' ? 0 : 1,
        email: email,
        telefone: telefoneSemMascara,
        endereco: EnderecoProfileModel(
          id: enderecoId,
          cep: cepSemMascara,
          rua: rua,
          numero: numero,
          complemento: complemento, // Envia o complemento do usuário
          bairro: bairro,
          cidade: cidade,
          uf: uf,
        ),
        aceitaTermos: aceitaTermos,
        aceitaNotificacoes: aceitaNotificacoes,
      );

      await _userProfileDatasource.updateUserProfile(updatedProfile);

      await carregarPerfil(userId!); // Re-carrega os dados frescos

    } on AppExceptions catch (e) {
      rethrow;
    } catch (e) {
      throw GenericException(message: 'Não foi possível atualizar o perfil: ${e.toString()}');
    } finally {
      carregando = false;
    }
  }
}