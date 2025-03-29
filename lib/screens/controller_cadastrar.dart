import 'package:agenda_sus/screens/api_cep.dart';
import 'package:mobx/mobx.dart';
part 'controller_cadastrar.g.dart';

class ControllerCadastrar = _ControllerCadastrar with _$ControllerCadastrar;

abstract class _ControllerCadastrar with Store {
  @observable
  String nome = "";

  @observable
  String cpf = "";

  @observable
  String cns = "";

  @observable
  String dataNascimento = "";

  @observable
  String genero = "";

  @observable
  String email = "";

  @observable
  String telefone = "";

  @observable
  String cep = "";

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

  @computed
  bool get CEPValidado => cep.length == 10 ? true : false;

  @action
  void setNome(value) => nome = value;

  @action
  void setCPF(value) => cpf = value;

  @action
  void setCNS(value) => cns = value;

  @action
  void setDataNascimento(value) => dataNascimento = value;

  @action
  void setGenero(value) => genero = value;

  @action
  void setEmail(value) => email = value;

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
  Future<void> buscarCep() async {
    if (CEPValidado) {
      try {
        final ApiCep apiCep = ApiCep();
        final endereco = await apiCep.buscarCep(cep);

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
