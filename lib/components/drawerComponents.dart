import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/crud_publishing_company/list_publishing_company_page.dart';
import 'package:locadora_de_livros/ui/list_book/list_books_page.dart';
import 'package:locadora_de_livros/ui/list_client/client_page.dart';
import 'package:locadora_de_livros/ui/list_rent/list_rent_page.dart';
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
                    border: Border.all(color: Colors.white, width: 3),
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
        itemDrawer("Usuários", Icons.person,  ListUserPage()),
        const SizedBox(height: 30),
        itemDrawer("Editoras", Icons.library_books, ListPublishingCompany()),
        const SizedBox(height: 30),
        itemDrawer("Livros", Icons.menu_book_rounded,  ListBooksPages()),
        const SizedBox(height: 30),
        itemDrawer("Aluguéis", Icons.calendar_month,  ListRentPage()),
      ],
    );
  }

   Widget itemDrawer(String name, IconData icon, dynamic route){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => route)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, size: 30),
                  const SizedBox(width: 10),
                  Text(name, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded)
          ]
        ),
      ),      
    );
  }


}

