import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/menu.dart';
import 'package:locadora_de_livros/service/books_service.dart';
import 'package:locadora_de_livros/ui/menu/menu_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

import '../../components/drawerComponents.dart';
import '../../widgets/appBarGlobal.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  BooksService booksService = BooksService();
  MenuController menuController = MenuController();

  @override
  void initState() {
    super.initState();
    menuController.initMenu(); 
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: const PreferredSize(preferredSize: Size.fromHeight(40), child: AppBarGlobal()),
      body:  Container( 
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        color: appColors.purple,
        child: Column(
          children: [
            menu(),
            dashboard(),
          ],
        ),
      )
    );
  }

  Widget menu(){
    return Expanded(
      child: Container(
        width:  MediaQuery.of(context).size.width,
        child: StreamBuilder<Menu>(
          stream: menuController.streamMenuController.stream,
          builder: (context, snapshot) {
            if(snapshot.data != null){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cards("Usuários",  appColors.blue, snapshot.data?.quantityClients??0),
                        const SizedBox(width: 10),
                        cards("Livros",  appColors.green, snapshot.data?.quantityBooks??0)
                      ],
                    ),
                    const SizedBox(height: 20),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cards("Aluguéis",  appColors.yellow, snapshot.data?.quantityRents??0),
                        const SizedBox(width: 10),
                        cards("Editoras",  appColors.red, snapshot.data?.quantityPublishingCompanies??0),
                      ],
                    ),
                  ]
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }

  Widget cards(String name, Color color, int? quantity){
    return Container(
      height: 120,
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: color, 
        borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$quantity", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            ],
          ),

        ],
      ),
    );
  }

  Widget dashboard(){
    return  Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      height: (MediaQuery.of(context).size.height / 2) - MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text("Livros mais alugados", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }

}