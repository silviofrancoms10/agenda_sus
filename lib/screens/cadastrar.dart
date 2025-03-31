import 'package:agenda_sus/screens/controller_cadastrar.dart';
import 'package:flutter/material.dart';
import 'package:agenda_sus/utils/campo_texto.dart';
import 'package:agenda_sus/utils/colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
// import 'package:provider/provider.dart';

class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  ControllerCadastrar controller = ControllerCadastrar();
  late ReactionDisposer reactionDisposer;
  late ReactionDisposer reactionDisposer2;
  late ReactionDisposer reactionDisposer3;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // controller = Provider.of<Controller>(context);

    reactionDisposer = reaction((_) => controller.CEPValidado, (_) {
      controller.buscarCep();
    });

    reactionDisposer2 = reaction((_) => controller.lgpdConfirmado, (_) {});
    reactionDisposer3 = reaction(
      (_) => controller.comunicacaoConfirmada,
      (_) {},
    );
  }

  @override
  void dispose() {
    reactionDisposer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteSmoke),
        title: const Text(
          'Cadastro AgendaSUS',
          style: TextStyle(color: whiteSmoke),
        ),
        backgroundColor: marianBlue, // Usando a cor do seu tema
      ),
      backgroundColor: vistaBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Informações pessoais:',
                  style: TextStyle(
                    color: whiteSmoke,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                CampoTexto(
                  labelText: 'Nome Completo',
                  hintText: 'ex: João da Silva Pereira',
                  onChanged: controller.setNome,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'CPF',
                  onChanged: controller.setCPF,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu CPF';
                    }
                    if (controller.cpfSemMascara.length < 11) {
                      return 'CPF deve ter 11 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Número do CNS',
                  onChanged: controller.setCNS,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CNSInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu CNS';
                    }
                    if (controller.cnsSemMascara.length < 15) {
                      return 'CNS deve ter 15 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Senha',
                  onChanged: controller.setSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma senha para acessar o sistema';
                    }
                    if (value.length < 7) {
                      return 'A senha deve ter 8 dígitos ou mais';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Confirma Senha',
                  onChanged: controller.setConfirmaSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value != controller.senha) {
                      return 'Insira uma senha para acessar o sistema';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CampoTexto(
                        labelText: 'Data de Nascimento',
                        hintText: 'ex: 01/01/1992',
                        onChanged: controller.setDataNascimento,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira sua data de nascimento';
                          }
                          if (controller.dataNascimento.length < 10) {
                            return 'Data de Nacimento Incompleta';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gênero',
                          labelStyle: TextStyle(
                            color: jetBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: jetBlack, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: jetBlack, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: marianBlue, width: 2),
                          ),
                        ),
                        dropdownColor: Colors.white, // Fundo branco do dropdown
                        isExpanded: true, // Ocupa apenas o tamanho necessário
                        onChanged: controller.setGenero,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Selecione seu gênero';
                          }
                          return null;
                        },
                        items:
                            <String>[
                              'Masculino',
                              'Feminino',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: jetBlack),
                                ),
                              );
                            }).toList(),
                        style: TextStyle(color: jetBlack),
                        icon: Icon(Icons.arrow_drop_down, color: jetBlack),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Contato:',
                  style: TextStyle(
                    color: whiteSmoke,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'E-mail',
                  hintText: 'ex: joao@gmail.com',
                  onChanged: controller.setEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu e-mail';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Confirma E-mail',
                  hintText: 'ex: joao@gmail.com',
                  onChanged: controller.setConfirmaEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu e-mail';
                    }
                    if (controller.emailsConferem == false) {
                      return 'Os e-mails devem ser iguais';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Telefone',
                  onChanged: controller.setTelefone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Endereço:',
                  style: TextStyle(
                    color: whiteSmoke,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'CEP',
                  hintText: 'ex: 79.002-000',
                  onChanged: controller.setCEP,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu CEP';
                    }
                    if (controller.cepSemMascara.length < 8) {
                      return 'Insira um CEP válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Observer(
                        builder:
                            (_) => CampoTexto(
                              labelText: 'Rua',
                              hintText: 'ex: Av. Brasil',
                              controller: controller.ruaController,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira a Rua / logradouro';
                                }
                                return null;
                              },
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: CampoTexto(
                        labelText: 'Nº',
                        onChanged: controller.setNumero,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  labelText: 'Complemento',
                  onChanged: controller.setComplemento,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
                Observer(
                  builder:
                      (_) => CampoTexto(
                        labelText: 'Bairro',
                        controller: controller.bairroController,
                        enabled: false,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o bairro';
                          }
                          return null;
                        },
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Observer(
                        builder:
                            (_) => CampoTexto(
                              labelText: 'Cidade',
                              controller: controller.cidadeController,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira a cidade';
                                }
                                return null;
                              },
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Observer(
                        builder:
                            (_) => CampoTexto(
                              labelText: 'UF',
                              controller: controller.ufController,
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira o estado';
                                }
                                return null;
                              },
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Observer(
                        builder:
                            (_) => Checkbox(
                              value: controller.lgpd,
                              onChanged: (_) => controller.setLGPD(),
                              activeColor: marianBlue,
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: GestureDetector(
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog(
                                    insetPadding: const EdgeInsets.all(
                                      20,
                                    ), // Margem ao redor
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 600,
                                      ), // Altura máxima
                                      padding: const EdgeInsets.all(20),
                                      child: SingleChildScrollView(
                                        child: termosDeUso(context),
                                      ),
                                    ),
                                  ),
                            ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: "Li e concordo com os "),
                              TextSpan(
                                text:
                                    "Termos de Uso e Políticas de Privacidade",
                                style: TextStyle(
                                  color: whiteSmoke,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: whiteSmoke,
                                ),
                              ),
                            ],
                            style: TextStyle(color: whiteSmoke, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Observer(
                        builder:
                            (_) => Checkbox(
                              value: controller.comunicacao,
                              onChanged: (_) => controller.setComunicacao(),
                              activeColor: marianBlue,
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Text(
                        "Aceito receber Notificações/SMS/E-mail",
                        style: TextStyle(color: whiteSmoke, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(marianBlue),
                        ),
                        onPressed: () {
                          testeCadastrar();
                        },
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(color: whiteSmoke),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  testeCadastrar() {
    if (_formKey.currentState!.validate()) {
      print('=== DADOS DO FORMULÁRIO (SEM MÁSCARA) ===');
      print('Nome: ${controller.nome}');
      print('CPF: ${controller.cpfSemMascara}');
      print('CNS: ${controller.cnsSemMascara}');
      print('Data Nascimento: ${controller.dataNascimento}');
      print('Gênero: ${controller.genero}');
      print('Email: ${controller.email}');
      print('Telefone: ${controller.telefoneSemMascara}');
      print('CEP: ${controller.cepSemMascara}');
      print('Endereço: ${controller.ruaController.text}, ${controller.numero}');
      print('Complemento: ${controller.complemento}');
      print('Bairro: ${controller.bairroController.text}');
      print('Cidade: ${controller.cidadeController.text}');
      print('UF: ${controller.ufController.text}');
      print('LGPD: ${controller.lgpd}');
      print('Comunicações: ${controller.comunicacao}');

      // Se todas as validações passarem
      print('Dados válidos, pronto para enviar!');

      // Aqui você pode chamar o método para enviar os dados para a API
      // enviarParaAPI();
    }
  }
}

termosDeUso(context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        "TERMOS E CONDIÇÕES DE USO E POLÍTICAS DE PRIVACIDADE",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      const Text(
        "1. Aceitação dos Termos\n\nAo utilizar o Agenda SUS, você concorda com estes termos...\n\n"
        "2. Uso do Aplicativo\n\nO aplicativo destina-se ao agendamento...\n\n"
        // Adicione todo o texto dos termos aqui
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
        textAlign: TextAlign.justify,
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Fechar"),
      ),
    ],
  );
}
