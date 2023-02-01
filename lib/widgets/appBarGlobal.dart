import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class AppBarGlobal extends StatefulWidget {
  const AppBarGlobal({super.key});

  @override
  State<AppBarGlobal> createState() => _AppBarGlobalState();
}

class _AppBarGlobalState extends State<AppBarGlobal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appColors.purple,
      leading: IconButton(icon: const Icon(FontAwesomeIcons.bars), onPressed: () => Scaffold.of(context).openDrawer()),
      elevation: 0,
    );
  }
}