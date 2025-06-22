// lib/features/home/presentation/pages/sus_card_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/features/home/presentation/controllers/sus_card_controller.dart'; 

class SusCardPage extends StatefulWidget {
  const SusCardPage({super.key});

  @override
  State<SusCardPage> createState() => _SusCardPageState();
}

class _SusCardPageState extends State<SusCardPage> {
  late SusCardController _susCardController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _susCardController = Provider.of<SusCardController>(context);
  }

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
                left: MediaQuery.of(context).size.width * 0.24, 
                top: MediaQuery.of(context).size.height * 0.26, 
                child: Transform.rotate(
                  angle: pi / 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(builder: (_) {
                        return Text(
                          _susCardController.nome,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      }),
                      Row(
                        children: [
                          Observer(builder: (_) {
                            return Text(
                              'Nascimento: ${_susCardController.dataNascimento}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            );
                          }),
                          const SizedBox(width: 16),
                          Observer(builder: (_) {
                            return Text(
                              'Sexo: ${_susCardController.sexo}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            );
                          }),
                        ],
                      ),
                      Observer(builder: (_) {
                        return Text(
                          'CNS: ${_susCardController.numeroCartao}', 
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
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