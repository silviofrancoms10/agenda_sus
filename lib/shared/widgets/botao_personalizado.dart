import 'package:flutter/material.dart';
import 'package:agenda_sus/shared/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotaoPersonalizado extends StatelessWidget {
  final String texto;
  final IconData? icone; // Alterado para IconData
  final VoidCallback? onPressed;
  final Color corFundo;
  final Color corTexto;
  final double? largura;
  final double altura;
  final double tamanhoIcone;
  final double tamanhoFonte;

  const BotaoPersonalizado({
    super.key,
    required this.texto,
    this.icone,
    this.onPressed,
    this.corFundo = trueBlue,
    this.corTexto = Colors.white,
    this.largura = 160,
    this.altura = 165,
    this.tamanhoIcone = 80,
    this.tamanhoFonte = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: largura,
      height: altura,
      padding: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: marianBlue, width: 1.4),
          ),
          backgroundColor: corFundo,
          foregroundColor: corTexto,
          padding: const EdgeInsets.all(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icone != null)
              FaIcon(
                // Usando FaIcon aqui
                icone,
                size: tamanhoIcone,
                color: corTexto,
              ),
            const SizedBox(height: 2), // Espaço entre ícone e texto
            Text(
              texto,
              style: TextStyle(
                fontSize: tamanhoFonte,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
