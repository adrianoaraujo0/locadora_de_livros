import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/ui/create_client/create_client_page.dart';
import 'package:locadora_de_livros/ui/list_client/list_client_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListUserPage extends StatelessWidget {
  ListUserPage({super.key});

  final ListClientController listClientController = ListClientController();

  @override
  Widget build(BuildContext context) {
    listClientController.streamListClient.sink.add([Client(name: "TESTE"),Client(name: "AESTE2"),]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Clientes", style: TextStyle(color: appColors.white)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: appColors.white), onPressed: ()=> Navigator.pop(context)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => CreateClientPage())), 
            icon: const Icon( Icons.add))
        ],
      ),
      body: StreamBuilder<List<Client>>(
        stream: listClientController.streamListClient.stream,
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return const Center(child: Text("Nenhum livro registrado.", style: TextStyle(fontSize: 25)));
          }else{
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  searchWidget(),
                  const SizedBox(height: 15),
                  listViewUsers(context, snapshot.data!)
                ],
              ),
            );
          }
        }
      ),
    );
  }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
        decoration: InputDecoration(
          hintText: "Insira o nome do usuário",
          focusColor: appColors.white,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ),
      )
    );
  }

  Widget listViewUsers(BuildContext context, List<Client> clients){
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: clients.length,
        itemBuilder:(context, index) {
          return itemListViewUsers(index, clients[index]);
        }, 
      ),
    );
  }

  Widget itemListViewUsers(int index, Client client){
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
              children:  [
                Text(client.name!, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text(client.email??"null", style: const TextStyle(fontSize: 15)),
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

  Widget addButton(BuildContext context){
    return InkWell(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CreateClientPage())),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(65)),color: appColors.purple),
        height: 70,
        width: 120,
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: appColors.purpleDark),
            child: const Icon(Icons.add, color: appColors.white),
          ),
        ),
      ),
    );
  }

}