import 'package:agenda_sus/screens/api_cep.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
part 'controller_cadastrar.g.dart';

class ControllerCadastrar = _ControllerCadastrar with _$ControllerCadastrar;

abstract class _ControllerCadastrar with Store {
  @observable
  String nome = "";

  @observable
  String cpf = "";

  String get cpfSemMascara => cpf.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String cns = "";

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

  String get telefoneSemMascara => telefone.replaceAll(RegExp(r'[^0-9]'), '');

  @observable
  String cep = "";

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
  bool get SenhasIguais => senha == confirmaSenha ? true : false;

  @computed
  bool get emailsConferem => email == confirmaEmail;

  @computed
  bool get CEPValidado => cepSemMascara.length > 7 ? true : false;

  TextEditingController get ruaController => TextEditingController(text: rua);

  TextEditingController get bairroController =>
      TextEditingController(text: bairro);

  TextEditingController get cidadeController =>
      TextEditingController(text: cidade);

  TextEditingController get ufController => TextEditingController(text: uf);

  @computed
  bool get lgpdConfirmado => lgpd;

  @computed
  bool get comunicacaoConfirmada => comunicacao;

  @action
  void setNome(value) => nome = value;

  @action
  void setCPF(value) => cpf = value;

  @action
  void setCNS(value) => cns = value;

  @action
  void setSenha(value) => senha = value;

  @action
  void setConfirmaSenha(value) => confirmaSenha = value;

  @action
  void setDataNascimento(value) => dataNascimento = value;

  @action
  void setGenero(value) => genero = value;

  @action
  void setEmail(value) => email = value;

  @action
  void setConfirmaEmail(value) => confirmaEmail = value;

  @action
  void setTelefone(value) => telefone = value;

  @action
  void setCEP(value) => cep = value;

  @action
  void setRua(value) => rua = value;

  @action
  void setNumero(value) => numero = value;

  @action
  void setComplemento(value) => complemento = value;

  @action
  void setBairro(value) => bairro = value;

  @action
  void setCidade(value) => cidade = value;

  @action
  void setUF(value) => uf = value;

  @action
  bool setLGPD() => lgpd = !lgpd;

  @action
  bool setComunicacao() => comunicacao = !comunicacao;

  @action
  Future<void> buscarCep() async {
    if (CEPValidado) {
      try {
        final ApiCep apiCep = ApiCep();
        final endereco = await apiCep.buscarCep(cepSemMascara);

        print("Entrou na busca do CEP");

        runInAction(() {
          setRua(endereco.logradouro);
          setBairro(endereco.bairro);
          setCidade(endereco.localidade);
          setUF(endereco.uf);
        });
      } catch (e) {
        print("Erro ao buscar CEP: $e");
      }
    }
  }
}
