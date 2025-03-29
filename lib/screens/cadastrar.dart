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
  final _formKey = GlobalKey<FormState>();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // controller = Provider.of<Controller>(context);

    reactionDisposer = reaction((_) => controller.CEPValidado, (_) {
      controller.buscarCep();
    });
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
        title: const Text(
          'Cadastro AgendaSUS',
          style: TextStyle(color: whiteSmoke),
        ),
        backgroundColor: marianBlue, // Usando a cor do seu tema
      ),
      backgroundColor: vistaBlue,
      body: SingleChildScrollView(
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
                  if (value.length != 15) {
                    return 'CNS deve ter 15 dígitos';
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
                            onChanged: controller.rua,
                            enabled: false,
                            textInputAction: TextInputAction.next ,
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
                      onChanged: controller.setNumero, // Jamilton, sei que set não tem o propósito de pegar o valor
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              Observer(
                builder:
                    (_) => CampoTexto(
                      labelText: 'Bairro',
                      onChanged: controller.setBairro,
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
                            onChanged: controller.setCidade,
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
                            onChanged: controller.setUF,
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
            ],
          ),
        ),
      ),
    );
  }
}
