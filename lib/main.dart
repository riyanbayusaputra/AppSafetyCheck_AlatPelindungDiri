import 'package:cp6_apd/data/datasources/auth_datasources.dart';
import 'package:cp6_apd/providers/dashboard_provider.dart';
import 'package:cp6_apd/views/dashboard/login_page.dart';
import 'package:cp6_apd/views/dashboard/started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:cp6_apd/bloc/login/login_bloc.dart';
import 'package:cp6_apd/bloc/register/register_bloc.dart';

import 'package:cp6_apd/views/dashboard/dashboard_view.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider untuk DashboardProvider
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
        ),
        // ChangeNotifierProvider untuk BeritaPanelProvider
        ChangeNotifierProvider(
          create: (context) => BeritaPanelProvider(),
        ),
        // BlocProvider untuk RegisterBloc
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        // BlocProvider untuk LoginBloc
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        // BlocProvider untuk Bloc lainnya bisa ditambahkan di sini jika diperlukan
      ],
      child: const MyApp(), // Memisahkan MaterialApp ke widget terpisah
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
