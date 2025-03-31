import 'package:agenda_sus/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:agenda_sus/utils/colors.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      title: 'Agenda SUS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: marianBlue,
          primary: marianBlue,
          secondary: trueBlue,
          surface: whiteSmoke,
          onPrimary: Colors.white,
          onSecondary: whiteSmoke,
          onSurface: jetBlack,    
          ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: vistaBlue
      ),
    );
  }
}
