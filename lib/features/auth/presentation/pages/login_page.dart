// lib/features/auth/presentation/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/features/auth/presentation/controllers/login_controller.dart';
import 'package:agenda_sus/features/home/presentation/pages/main_app_page.dart';
import 'package:agenda_sus/features/auth/presentation/pages/register_page.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';

import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:agenda_sus/shared/widgets/campo_texto.dart';
import 'package:agenda_sus/shared/utils/termos_uso.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController loginController;
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginController = Provider.of<LoginController>(context);
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (_formKeyLogin.currentState?.validate() ?? false) {
      try {
        await loginController.logar();

        if (!mounted) return;

        if (loginController.usuarioLogado) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MainAppPage(usuario: loginController.usuarioAtual!),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro: Usuário não foi autenticado corretamente'),
              backgroundColor: Colors.red,
            ),
          );
        }
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
      backgroundColor: vistaBlue,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKeyLogin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo_agendasus.png'),
                      const SizedBox(height: 48),
                      CampoTexto(
                        labelText: 'E-mail',
                        onChanged: loginController.setEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe seu e-mail';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CampoTexto(
                        labelText: 'Senha',
                        obscureText: true,
                        onChanged: loginController.setSenha,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) => _handleLogin(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe sua senha';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Observer(builder: (_) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: jetBlack, width: 1),
                                  elevation: 5,
                                  minimumSize: const Size(0, 50),
                                  backgroundColor: marianBlue,
                                ),
                                onPressed: (loginController.carregando || !loginController.isFormValid) ? null : () {
                                  _handleLogin();
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
                            }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: jetBlack, width: 1),
                                elevation: 5,
                                minimumSize: const Size(0, 50),
                                backgroundColor: whiteSmoke,
                              ),
                              onPressed: loginController.carregando ? null : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                                );
                              },
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
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Funcionalidade de "Esqueceu a senha?" em desenvolvimento.'),
                                  backgroundColor: marianBlue,
                                ),
                              );
                            },
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: whiteSmoke,
                                fontWeight: FontWeight.bold, // Adicionado negrito aqui
                                fontSize: 16, // Aumentado o tamanho da fonte
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => showDialog(
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
                            child: Text(
                              'Política de Privacidade',
                              style: TextStyle(
                                color: whiteSmoke,
                                fontWeight: FontWeight.bold, // Adicionado negrito aqui
                                fontSize: 16, // Aumentado o tamanho da fonte
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
          ),
          Observer(builder: (_) {
            return loginController.carregando
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}