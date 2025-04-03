import 'package:agenda_sus/screens/controller_login.dart';
import 'package:agenda_sus/screens/principal.dart';
import 'package:agenda_sus/utils/termos_uso.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_sus/screens/cadastrar.dart';
import 'package:agenda_sus/utils/campo_texto.dart';
import 'package:agenda_sus/utils/colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ControllerLogin loginController = ControllerLogin();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vistaBlue,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Image.asset('images/logo_agendasus.png'),
                  // Campo de CPF/CNS dinâmico
                  CampoTexto(
                    hintText: 'CPF - Cadastro de Pessoa Física',
                    labelText: 'CPF - Cadastro de Pessoa Física',
                    onChanged: loginController.setCpf,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu CPF para fazer Login';
                      }
                      if (loginController.cpfSemMascara.length < 11) {
                        return 'CPF inválido, deve conter 11 dígitos';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  CampoTexto(
                    hintText: 'Senha',
                    labelText: 'Senha',
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onChanged: (value) => loginController.setSenha(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe sua senha para fazer Login';
                      }
                      if (value.length < 7) {
                        return 'Senha inválida, deve conter no mínimo 8 dígitos';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Observer(
                          builder: (_) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: jetBlack, width: 1),
                                elevation: 5,
                                minimumSize: const Size(0, 50),
                                backgroundColor: marianBlue,
                              ),
                              onPressed:
                                  loginController.carregando
                                      ? null
                                      : () async {
                                        if (loginController.isValid) {
                                          await loginController.logar();
                                          if (loginController.usuarioLogado) {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (_) => Principal(),
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Dados inválidos'),
                                            ),
                                          );
                                        }
                                      },
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  color: whiteSmoke,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              loginController.carregando
                                  ? null
                                  : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Cadastrar(),
                                      ),
                                    );
                                  },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: jetBlack, width: 1),
                            elevation: 5,
                            minimumSize: const Size(0, 50),
                            backgroundColor: whiteSmoke,
                          ),
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: marianBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Links adicionais
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                          color: whiteSmoke,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: loginController.carregando ? null : () {},
                        child: Text(
                          "Clique aqui",
                          style: TextStyle(
                            color: whiteSmoke,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: whiteSmoke,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed:
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
                    child: Text(
                      "Termos de Uso e Políticas de Privacidade",
                      style: TextStyle(
                        color: whiteSmoke,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlay de carregamento
          Observer(
            builder: (_) {
              return loginController.carregando
                  ? Container(
                    color: Color.from(alpha: 0.2, red: 0, green: 0, blue: 0),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
