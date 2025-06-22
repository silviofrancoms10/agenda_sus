import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda_sus/core/network/dio_client.dart';
import 'package:agenda_sus/core/errors/exceptions.dart';

import 'package:agenda_sus/features/address/data/datasources/viacep_datasource.dart';

import 'package:agenda_sus/features/auth/data/datasources/auth_datasource.dart';
import 'package:agenda_sus/features/auth/presentation/controllers/register_controller.dart';
import 'package:agenda_sus/features/auth/presentation/controllers/login_controller.dart';
import 'package:agenda_sus/features/auth/presentation/pages/login_page.dart';

import 'package:agenda_sus/features/home/presentation/controllers/home_controller.dart';
import 'package:agenda_sus/features/home/presentation/controllers/main_app_controller.dart';
import 'package:agenda_sus/features/home/presentation/controllers/sus_card_controller.dart';
import 'package:agenda_sus/features/home/presentation/pages/main_app_page.dart';

// Novos imports para o perfil do usuário
import 'package:agenda_sus/features/user_profile/data/datasources/user_profile_datasource.dart';
import 'package:agenda_sus/features/user_profile/presentation/controllers/user_profile_controller.dart';
import 'package:agenda_sus/features/home/presentation/pages/perfil.dart'; // <--- AQUI! Caminho atualizado
import 'package:agenda_sus/shared/utils/colors.dart';


void main() {
  final dioClient = DioClient();

  final viaCepDatasource = ViaCepDatasource(dioClient);
  final authDatasource = AuthDatasourceImpl(dioClient);
  final userProfileDatasource = UserProfileDatasourceImpl(dioClient);

  final registerController = RegisterController(viaCepDatasource, authDatasource);
  final loginController = LoginController(authDatasource, dioClient);
  
  final homeController = HomeController();
  final mainAppController = MainAppController();
  final susCardController = SusCardController();
  final userProfileController = UserProfileController(userProfileDatasource, viaCepDatasource);


  runApp(
    MultiProvider(
      providers: [
        Provider<RegisterController>(
          create: (_) => registerController,
        ),
        Provider<LoginController>(
          create: (_) => loginController,
        ),
        Provider<HomeController>(
          create: (_) => homeController,
        ),
        Provider<MainAppController>(
          create: (_) => mainAppController,
        ),
        Provider<SusCardController>(
          create: (_) => susCardController,
        ),
        Provider<UserProfileController>(
          create: (_) => userProfileController,
        ),
      ],
      child: const MainApp(), 
    ),
  );
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
      
      home: const LoginPage(), 
      
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