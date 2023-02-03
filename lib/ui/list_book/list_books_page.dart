import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_page.dart';
import 'package:locadora_de_livros/ui/list_book/list_book_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListBooksPages extends StatefulWidget {
  ListBooksPages({super.key});

  @override
  State<ListBooksPages> createState() => _ListBooksPagesState();
}

class _ListBooksPagesState extends State<ListBooksPages> {
  final ListBooksController listBooksController = ListBooksController();

  @override
  void initState() {
    super.initState();

    listBooksController.initListBookPage();
  }

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
            onPressed: () {
              Navigator.push(
                context,MaterialPageRoute( builder: (context) => CreateBookPage())
              ).then((_) async => await listBooksController.initListBookPage());
            }, 
            icon: const Icon( Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
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
      ),
    );
  }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
        onChanged: (value) => listBooksController.search(value),
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
    return StreamBuilder<List<Book>>(
      initialData: null,
      stream: listBooksController.streamBook.stream,
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
              itemCount: snapshot.data!.length,
              itemBuilder:(context, index) {
                return itemListViewUsers(snapshot.data![index] ,index);
              }, 
            ),
          );
        }
      }
    );
  }

  Widget itemListViewUsers(Book book ,int index){
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
                Text("${book.title}", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text("${book.author}", style: const TextStyle(fontSize: 15)),
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