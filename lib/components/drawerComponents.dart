
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: appColors.white,
      child: Column(
        children: [
          headerDrawer(),
          bodyDrawer()
        ],
      ),
    );
  }

  Widget headerDrawer(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            color: appColors.purple,
          ),
          Positioned(
            bottom: 45,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(image: AssetImage("assets/images/user.png"))
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bodyDrawer(){
    return Column(
      children: [
        //INICIO, USUARIO, EDITORAS, LIVROS, ALUGUEIS
        itemDrawer("Início", Icons.house),
      ],
    );
  }

   Widget itemDrawer(String name, IconData icon){
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.house),
                const SizedBox(width: 10),
                Text(name),
              ],
            ),
          ),
          const Icon(Icons.arrow_right)
        ]
      ),      
    );
  }
}

