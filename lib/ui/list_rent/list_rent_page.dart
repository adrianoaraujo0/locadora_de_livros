import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_page.dart';
import 'package:locadora_de_livros/ui/create_rent/create_rent_page.dart';
import 'package:locadora_de_livros/ui/list_rent/list_rent_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListRentPage extends StatefulWidget {
  ListRentPage({super.key});

  @override
  State<ListRentPage> createState() => _ListRentPageState();
}

class _ListRentPageState extends State<ListRentPage> {
  final ListRentController listRentController = ListRentController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Aluguéis", style: TextStyle(color: appColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appColors.white), 
          onPressed: () async{
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 300)).whenComplete(() => Navigator.pop(context));
          }
         ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,MaterialPageRoute( builder: (context) => CreateRentPage())
              ).then((_) async => await listRentController.initListRentPage());
            }, 
            icon: const Icon( Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              searchWidget(),
              const SizedBox(height: 15),
              listViewRent(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
        // onChanged: (value) => listBooksController.search(value),
        decoration: InputDecoration(
          hintText: "Insira a data do aluguel",
          focusColor: appColors.white,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ),
      )
    );
  }

  Widget listViewRent(BuildContext context){
    return StreamBuilder<List<Rent>>(
      initialData: [Rent()],
      stream: listRentController.streamRents.stream,
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
              itemCount: 2,
              itemBuilder:(context, index) {
                return itemListViewRent(index);
              }, 
            ),
          );
        }
      }
    );
  }

  Widget itemListViewRent(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              children: const  [
                Text("Cliente: adriano", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text("Livro: Beserk", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text("retirada: 01/02/2023", style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 5),
                Text("devolução: 05/02/2023", style: const TextStyle(fontSize: 15)),
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