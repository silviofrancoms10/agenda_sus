import 'package:flutter/material.dart';
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
