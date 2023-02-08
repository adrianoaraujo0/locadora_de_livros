import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/ui/create_client/create_client_page.dart';
import 'package:locadora_de_livros/ui/list_client/list_client_controller.dart';
import 'package:locadora_de_livros/ui/update_client/update_client_page.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListClientPage extends StatefulWidget {
  ListClientPage({super.key});

  @override
  State<ListClientPage> createState() => _ListClientPageState();
}

class _ListClientPageState extends State<ListClientPage> {
  final ListClientController listClientController = ListClientController();

  @override
  void initState() {
    super.initState();
    listClientController.initListClientPage();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Clientes", style: TextStyle(color: appColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
          color: appColors.white),
          onPressed: ()async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 300)).whenComplete(() => Navigator.pop(context));
          }),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
               Navigator.push(
                context,MaterialPageRoute( builder: (context) => CreateClientPage())
              ).then((_) async => await listClientController.initListClientPage());
            },
            icon: const Icon( Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              searchWidget(),
              const SizedBox(height: 15),
              listViewUsers(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
        onChanged: (value) => listClientController.search(value),
        decoration: InputDecoration(
          hintText: "Insira o nome do usuário",
          focusColor: appColors.white,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ),
      )
    );
  }

  Widget listViewUsers(BuildContext context){
    return StreamBuilder<List<Client>>(
      stream: listClientController.streamClient.stream,
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.data!.isEmpty){
          return const Center(child: Text("Não há usuários cadastrados"));
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder:(context, index) {
              return itemListViewUsers(index, snapshot.data![index]);
            }, 
          ),
        );
      }
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
          InkWell(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => UpdateClientPage(idClient: client.id!)
                )
              ).then((_) async => await listClientController.initListClientPage());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.edit, color: appColors.grey),
            )
          ),
        ]
      ),
    );
  }
}