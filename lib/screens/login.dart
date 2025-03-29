import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_sus/screens/cadastrar.dart';
import 'package:agenda_sus/utils/campo_texto.dart';
import 'package:agenda_sus/utils/colors.dart';
import 'package:brasil_fields/brasil_fields.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isCpf = true;

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  TextInputFormatter _getFormatter(String text) {
    final cleanText = text.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanText.length <= 11 ? CpfInputFormatter() : CNSInputFormatter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vistaBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Image.asset('images/logo_agendasus.png'),
              // Campo de CPF/CNS dinâmico
              CampoTexto(
                hintText: 'CPF ou CNS',
                labelText:
                    _isCpf
                        ? 'CPF - Cadastro de Pessoa Física'
                        : 'CNS - Cartão Nacional de Saúde',
                controller: _loginController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return _getFormatter(
                      newValue.text,
                    ).formatEditUpdate(oldValue, newValue);
                  }),
                ],
                onChanged: (value) {
                  final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  setState(() {
                    _isCpf = cleanValue.length <= 11;
                  });
                },
              ),

              const SizedBox(height: 16),

              CampoTexto(
                hintText: 'Senha',
                labelText: 'Senha',
                obscureText: true,
                controller: _senhaController,
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _validarERealizarLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: jetBlack, width: 1),
                        elevation: 5,
                        minimumSize: const Size(0, 50),
                        backgroundColor: marianBlue,
                      ),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: whiteSmoke,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
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

              const SizedBox(height: 16),

              // Links adicionais
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(
                      color: whiteSmoke,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Clique aqui".toUpperCase(),
                      style: TextStyle(
                        color: whiteSmoke,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: whiteSmoke,
                      ),
                    ),
                  ),
                ],
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  "Termos de Uso e Políticas de Privacidade",
                  style: TextStyle(
                    color: whiteSmoke,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validarERealizarLogin() {
    final login = _loginController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final senha = _senhaController.text;

    if (login.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, informe seu CPF ou CNS')),
      );
      return;
    }

    if (senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, informe sua senha')),
      );
      return;
    }

    // Validação específica para CPF (11 dígitos)
    if (login.length == 11 && !CPFValidator.isValid(login)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CPF inválido')));
      return;
    }

    // Validação específica para CNS (15 dígitos)
    if (login.length == 15 && !_validarCNS(login)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CNS inválido')));
      return;
    }

    // Aqui você implementaria a lógica de login real
    _realizarLogin(login, senha);
  }

  bool _validarCNS(String cns) {
    // Implemente a validação real do CNS aqui
    // Este é um exemplo básico - a validação real do CNS é mais complexa
    return cns.length == 15;
  }

  void _realizarLogin(String login, String senha) {
    // Implemente sua lógica de autenticação aqui
    print('Tentativa de login com: $login e senha: $senha');
  }
}
