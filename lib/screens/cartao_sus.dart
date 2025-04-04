import 'dart:math';
import 'package:flutter/material.dart';

class CartaoSUS extends StatelessWidget {
  final String nome;
  final String numeroCartao;
  final String dataNascimento;
  final String sexo;

  const CartaoSUS({
    super.key,
    required this.nome,
    required this.numeroCartao,
    required this.dataNascimento,
    required this.sexo,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('images/cartaoImage.png'),
              Positioned(
                left:
                    MediaQuery.of(context).size.width *
                    0.24, // ← Ajuste este valor
                top:
                    MediaQuery.of(context).size.height *
                    0.26, // ← Ajuste este valor
                child: Transform.rotate(
                  angle: pi / 2, // Gira o texto 90 graus à esquerda
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Nascimento: $dataNascimento',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Sexo: $sexo',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        'CNS: $numeroCartao',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
