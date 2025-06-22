// lib/features/auth/presentation/pages/register_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para FilteringTextInputFormatter
import 'package:flutter_mobx/flutter_mobx.dart'; // Para usar Observer
import 'package:mobx/mobx.dart'; // Para ReactionDisposer
import 'package:provider/provider.dart'; // Importe o Provider

// Importe suas classes e caminhos atualizados
import 'package:agenda_sus/features/auth/presentation/controllers/register_controller.dart';
import 'package:agenda_sus/shared/widgets/campo_texto.dart'; // Caminho atualizado
import 'package:agenda_sus/shared/utils/colors.dart'; // Caminho atualizado
import 'package:agenda_sus/shared/utils/termos_uso.dart'; // Caminho atualizado
import 'package:agenda_sus/core/errors/exceptions.dart'; // Importe suas exceções personalizadas

// Importes do brasil_fields - mantenha-os se ainda estiverem em uso direto aqui
import 'package:brasil_fields/brasil_fields.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // O controller será inicializado em didChangeDependencies via Provider
  late RegisterController controller;

  late ReactionDisposer reactionDisposerCep;
  late ReactionDisposer reactionDisposerLgpd;
  late ReactionDisposer reactionDisposerComunicacao;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtém a instância do RegisterController que foi fornecida no main.dart
    controller = Provider.of<RegisterController>(context);

    // Reações MobX
    reactionDisposerCep = reaction((_) => controller.CEPValidado, (_) {
      // Chama a ação do controller para buscar o CEP
      // O tratamento de erro ocorre dentro do controller, mas a UI pode mostrar um SnackBar
      controller.buscarCep().catchError((error) {
        String errorMessage = 'Erro desconhecido ao buscar CEP.';
        if (error is AppExceptions) {
          errorMessage = error.message; // Pega a mensagem da sua exceção customizada
        } else if (error != null) {
          errorMessage = error.toString();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.orange, // Cor para erros relacionados a CEP
          ),
        );
      });
    });

    reactionDisposerLgpd = reaction((_) => controller.lgpdConfirmado, (_) {});
    reactionDisposerComunicacao = reaction(
      (_) => controller.comunicacaoConfirmada,
      (_) {},
    );
  }

  @override
  void dispose() {
    // Descarte as reações MobX quando o widget não for mais necessário
    reactionDisposerCep();
    reactionDisposerLgpd();
    reactionDisposerComunicacao();
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
        backgroundColor: marianBlue,
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
                  textCapitalization: TextCapitalization.words,
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
                      return 'As senhas não coincidem';
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
                            return 'Data de Nascimento Incompleta';
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
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        onChanged: controller.setGenero,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Selecione seu gênero';
                          }
                          return null;
                        },
                        items: <String>[
                          'Feminino', // 0 para Feminino
                          'Masculino', // 1 para Masculino
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
                      return 'Confirme seu e-mail';
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
                      return 'Insira um CEP válido (8 dígitos)';
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
                        builder: (_) => CampoTexto(
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
                  builder: (_) => CampoTexto(
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
                        builder: (_) => CampoTexto(
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
                        builder: (_) => CampoTexto(
                          labelText: 'UF',
                          controller: controller.ufController,
                          enabled: false,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira o estado (UF)';
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
                        builder: (_) => Checkbox(
                          value: controller.lgpd,
                          onChanged: (_) => controller.setLGPD(),
                          activeColor: marianBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: const EdgeInsets.all(20),
                            child: Container(
                              constraints: const BoxConstraints(maxHeight: 600),
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
                                text: "Termos de Uso e Políticas de Privacidade",
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
                        builder: (_) => Checkbox(
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
                        onPressed: () async {
                          // A página agora chama uma ação no controller para submeter o cadastro
                          await _submitRegistration();
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

  // --- FUNÇÃO PARA SUBMETER O CADASTRO (LÓGICA DE UI) ---
  // Esta função agora apenas valida o formulário e chama a ação no controller.
  // A requisição HTTP real será movida para o controller (e suas camadas de dados).
  Future<void> _submitRegistration() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Chamada da ação de cadastro do controller
        // ESTA AÇÃO `cadastrarUsuario()` PRECISA SER CRIADA NO RegisterController
        await controller.cadastrarUsuario();

        // Feedback de sucesso na UI
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navegação de sucesso
        Navigator.pop(context);
      } on AppExceptions catch (e) {
        // Captura e exibe mensagens de erro customizadas vindas do controller/camadas de dados
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: e is NetworkException ? Colors.orange : Colors.red, // Cores diferentes para tipos de erro
          ),
        );
      } catch (e) {
        // Captura qualquer outro erro inesperado não tratado
        print('Erro inesperado: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocorreu um erro inesperado: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}