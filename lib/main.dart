import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/login/login_page.dart';
import 'package:locadora_de_livros/ui/menu/menu_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MenuPage());
  }
}

