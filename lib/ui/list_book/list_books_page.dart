import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_page.dart';
import 'package:locadora_de_livros/ui/list_book/list_book_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListBooksPages extends StatelessWidget {
  ListBooksPages({super.key});

  final ListBooksController listBooksController = ListBooksController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Livros", style: TextStyle(color: appColors.white)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: appColors.white), onPressed: ()=> Navigator.pop(context)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => CreateBookPage())), 
            icon: const Icon( Icons.add))
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                searchWidget(),
                const SizedBox(height: 15),
                listViewUsers(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
        decoration: InputDecoration(
          hintText: "Insira o nome do livro",
          focusColor: appColors.white,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ),
      )
    );
  }

  Widget listViewUsers(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder:(context, index) {
          return itemListViewUsers(index);
        }, 
      ),
    );
  }

  Widget itemListViewUsers(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: appColors.purple),
            child: Center(child: Text("${index + 1}", style: const TextStyle(color: appColors.white))),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Banco de Dados", style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                Text("Navathe", style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          const Icon(Icons.edit, color: appColors.grey),
          const SizedBox(width: 10),
          const Icon(Icons.delete, color: appColors.red)
        ]
      ),
    );
  }

}