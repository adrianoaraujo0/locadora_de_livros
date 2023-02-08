import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/graphicBooks.dart';
import 'package:locadora_de_livros/model/menu.dart';
import 'package:locadora_de_livros/model/rent.dart';
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
        height: double.maxFinite,
        width:  double.maxFinite,
        color: appColors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              menu(),
              dashboard(),
            ],
          ),
        ),
      )
    );
  }

  Widget menu(){
    return Container(
      color: appColors.purple,
      width:  MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 25),
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
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             const SizedBox(height: 15),
             graphicDashboard(),
             const SizedBox(height: 30),
             rentDashboard()
          ],
        ),
      ),
    );
  }

  Widget graphicDashboard(){
    return StreamBuilder<List<GraphicBooks>>(
      stream: menuController.streamGraphicBooks.stream,
      initialData: [],
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Livros mais alugados", style: TextStyle(fontSize: 25)),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width:  MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(border: Border.all(color: appColors.black)),
                child: Center(
                  child:  listViewBooks(snapshot.data!)
                ),
              ),
              nameBook(snapshot.data!)
            ],
          ),
        );
      }
    );
  }

  Widget listViewBooks(List<GraphicBooks> listBooks){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listBooks.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: itemGraphicDashboard(listBooks[index], menuController.colorsDashBoard[index]),
        );
      }, 
    );
  }

  Widget itemGraphicDashboard(GraphicBooks graphicBooks, Color color){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("${graphicBooks.quantity}"),
        const SizedBox(height: 10),
        AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height * (graphicBooks.quantity * 0.0025),
            width: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: color
            ),
        )
      ]
    );
  }

  Widget nameBook(List<GraphicBooks> listBooks){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child:  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[0],
          ),
          const SizedBox(width: 3),
          Text("O contato"),
          const SizedBox(width: 3),
          Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[1],
          ),
          const SizedBox(width: 3),
          Text("O sol é para todo"),
          const SizedBox(width: 3),
          Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[2],
          ),
          const SizedBox(width: 3),
           const SizedBox(width: 3),
          Text("Naruto HQ"),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[3],
          ),
          const SizedBox(width: 3),
          Text("On the road"),
          const SizedBox(width: 3),
          Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[4],
          ),
          const SizedBox(width: 3),
          Text("A revolução dos bichos"),
          const SizedBox(width: 3),
          Container(
            height: 10,
            width: 20,
            color: menuController.colorsDashBoard[5],
          ),
          const SizedBox(width: 3),
           const SizedBox(width: 3),
          Text("1984"),
            ],
          )
        ],
      ),
    );
  }

  Widget rentDashboard(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Últimos de aluguéis", style: TextStyle(fontSize: 25)),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width:  MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(border: Border.all(color: appColors.black)),
            child: Center(
              child: StreamBuilder<List<Rent>>(
                initialData: null,
                stream: menuController.streamRents.stream,
                builder: (context, snapshot) {
                  if(snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  }else if(snapshot.data!.isEmpty){
                    return const Center(child: Text("Nenhum livro foi cadastrado.", style: TextStyle(fontSize: 25)));
                  }else{
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length > 5 ?5 : snapshot.data!.length,
                        itemBuilder:(context, index) {
                          return itemListViewRent(snapshot.data![index] ,index);
                        }, 
                      ),
                    );
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget itemListViewRent(Rent rent ,int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: appColors.purple),
            child: Center(child: Text("${index + 1}", style: const TextStyle(color: appColors.white))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cliente: ${rent.nameClient}", style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 5),
                Text("Livro: ${rent.nameBook}", style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text("Status: ",  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 5,),
                    Text(
                      menuController.convertRentStatus(rent.rentStatus!), 
                      style: TextStyle(fontSize: 15, color: validationColorStatus(rent.rentStatus!))
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ]
      ),
    );
  }

    Color validationColorStatus(String rentStatus){
    if(rentStatus == "DELAY"){
      return appColors.red;
    }if(rentStatus == "ONTIME"){
      return appColors.green;
    }else{
      return appColors.yellow;
    } 
  }


}
