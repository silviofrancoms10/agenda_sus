// lib/features/home/presentation/pages/perfil.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/features/auth/data/models/user_model.dart';
import 'package:agenda_sus/features/user_profile/presentation/controllers/user_profile_controller.dart';
import 'package:agenda_sus/shared/widgets/campo_texto.dart';
import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:agenda_sus/shared/utils/termos_uso.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';
import 'package:agenda_sus/features/home/presentation/controllers/main_app_controller.dart';

import 'package:brasil_fields/brasil_fields.dart';

class Perfil extends StatefulWidget {
  final UserModel usuario;

  const Perfil({super.key, required this.usuario});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late UserProfileController controller;
  late MainAppController mainAppController;
  late ReactionDisposer reactionDisposerCep;
  late ReactionDisposer reactionAutorunDataSync;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cnsController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmaNovaSenhaController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  void _syncControllersWithMobXState() {
    _nomeController.text = controller.nome;
    _cpfController.text = controller.cpf;
    _cnsController.text = _formatCns(controller.cns);
    _dataNascimentoController.text = controller.dataNascimento;
    _emailController.text = controller.email;
    _telefoneController.text = _formatTelefone(controller.telefone);
    _cepController.text = controller.cep;
    _ruaController.text = controller.rua;
    _numeroController.text = controller.numero;
    _complementoController.text = controller.complemento;
    _bairroController.text = controller.bairro;
    _cidadeController.text = controller.cidade;
    _ufController.text = controller.uf;
    
    _novaSenhaController.clear();
    _confirmaNovaSenhaController.clear();
  }

  // Funções auxiliares para aplicar máscaras ao exibir
  String _formatCns(String cns) {
    if (cns == null || cns.isEmpty) return '';
    String digitsOnly = cns.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 15) return cns;
    // CORREÇÃO AQUI: 'digitsOnlyOnly' foi alterado para 'digitsOnly'
    return '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, 7)} ${digitsOnly.substring(7, 11)} ${digitsOnly.substring(11, 15)}';
  }

  String _formatTelefone(String telefone) {
    if (telefone == null || telefone.isEmpty) return '';
    String digitsOnly = telefone.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length == 10) {
      return '(' + digitsOnly.substring(0, 2) + ') ' + digitsOnly.substring(2, 6) + '-' + digitsOnly.substring(6);
    } else if (digitsOnly.length == 11) {
      return '(' + digitsOnly.substring(0, 2) + ') ' + digitsOnly.substring(2, 7) + '-' + digitsOnly.substring(7);
    }
    return telefone;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<UserProfileController>(context);
    mainAppController = Provider.of<MainAppController>(context);
    
    controller.carregarPerfil(widget.usuario.id).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar perfil: ${e is AppExceptions ? e.message : e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    });

    reactionAutorunDataSync = autorun((_) {
      if (!controller.carregando && controller.userId == widget.usuario.id) {
        _syncControllersWithMobXState();
      }
    });

    reactionDisposerCep = reaction((_) => controller.CEPValidado, (_) {
      if (controller.cepSemMascara.length == 8) {
        controller.buscarCep().then((_) {
          _ruaController.text = controller.rua;
          _bairroController.text = controller.bairro;
          _cidadeController.text = controller.cidade;
          _ufController.text = controller.uf;
        }).catchError((error) {
          String errorMessage = 'Erro desconhecido ao buscar CEP.';
          if (error is AppExceptions) {
            errorMessage = error.message;
          } else if (error != null) {
            errorMessage = error.toString();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.orange,
            ),
          );
          _ruaController.clear();
          _bairroController.clear();
          _cidadeController.clear();
          _ufController.clear();
          controller.setRua('');
          controller.setBairro('');
          controller.setCidade('');
          controller.setUF('');
        });
      } else {
        _ruaController.clear();
        _bairroController.clear();
        _cidadeController.clear();
        _ufController.clear();
        controller.setRua('');
        controller.setBairro('');
        controller.setCidade('');
        controller.setUF('');
      }
    });
  }

  @override
  void dispose() {
    reactionDisposerCep();
    reactionAutorunDataSync();

    _nomeController.dispose();
    _cpfController.dispose();
    _cnsController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _ufController.dispose();
    _novaSenhaController.dispose();
    _confirmaNovaSenhaController.dispose();

    super.dispose();
  }

  Future<void> _submitUpdate() async {
    if (_formKey.currentState!.validate()) {
      try {
        await controller.atualizarPerfil();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        _novaSenhaController.clear();
        _confirmaNovaSenhaController.clear();

      } on AppExceptions catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocorreu um erro inesperado: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteSmoke),
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: whiteSmoke),
        ),
        backgroundColor: marianBlue,
      ),
      backgroundColor: vistaBlue,
      body: SafeArea(
        child: Observer(
          builder: (_) => controller.carregando
              ? Center(
                  child: CircularProgressIndicator(color: marianBlue),
                )
              : SingleChildScrollView(
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
                          controller: _nomeController,
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
                          controller: _cpfController,
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
                          controller: _cnsController,
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
                        Text(
                          'Alterar Senha (Opcional):',
                          style: TextStyle(
                            color: whiteSmoke,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CampoTexto(
                          labelText: 'Nova Senha',
                          controller: _novaSenhaController,
                          onChanged: controller.setNovaSenha,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value != null && value.isNotEmpty && value.length < 8) {
                              return 'A nova senha deve ter 8 dígitos ou mais';
                            }
                            if (value != null && value.isNotEmpty && !controller.senhasConferem) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CampoTexto(
                          labelText: 'Confirmar Nova Senha',
                          controller: _confirmaNovaSenhaController,
                          onChanged: controller.setConfirmaNovaSenha,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (controller.novaSenha.isNotEmpty && (value == null || value.isEmpty)) {
                              return 'Confirme sua nova senha';
                            }
                            if (value != null && value.isNotEmpty && !controller.senhasConferem) {
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
                                controller: _dataNascimentoController,
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
                                value: controller.genero.isEmpty ? null : controller.genero,
                                isExpanded: true,
                                onChanged: controller.setGenero,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Selecione seu gênero';
                                  }
                                  return null;
                                },
                                items: const <String>[
                                  'Feminino',
                                  'Masculino',
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
                          controller: _emailController,
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
                          controller: _telefoneController,
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
                          controller: _cepController,
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
                              child: CampoTexto(
                                labelText: 'Rua',
                                hintText: 'ex: Av. Brasil',
                                controller: _ruaController,
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
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: CampoTexto(
                                labelText: 'Nº',
                                controller: _numeroController,
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
                          controller: _complementoController,
                          onChanged: controller.setComplemento,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 16),
                        CampoTexto(
                          labelText: 'Bairro',
                          controller: _bairroController,
                          enabled: false,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira o bairro';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CampoTexto(
                                labelText: 'Cidade',
                                controller: _cidadeController,
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
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: CampoTexto(
                                labelText: 'UF',
                                controller: _ufController,
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
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Observer(
                                builder: (_) => Checkbox(
                                  value: controller.aceitaTermos,
                                  onChanged: (bool? value) => controller.setAceitaTermos(value ?? false),
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
                                  value: controller.aceitaNotificacoes,
                                  onChanged: (bool? value) => controller.setAceitaNotificacoes(value ?? false),
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
                                  mainAppController.setIndiceAtual(0);
                                },
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Observer(builder: (_) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(marianBlue),
                                  ),
                                  onPressed: (controller.carregando || (!controller.dadosAlterados && controller.novaSenha.isEmpty)) ? null : _submitUpdate,
                                  child: controller.carregando
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Salvar Alterações",
                                          style: TextStyle(color: whiteSmoke),
                                        ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}