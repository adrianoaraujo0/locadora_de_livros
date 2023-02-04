import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/rent.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_controller.dart';
import 'package:locadora_de_livros/ui/create_rent/create_rent_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

// ignore: must_be_immutable
class CreateRentPage extends StatefulWidget {
  CreateRentPage({super.key});

  @override
  State<CreateRentPage> createState() => _CreateRentPageState();
}

class _CreateRentPageState extends State<CreateRentPage> {

  CreateRentController createRentController = CreateRentController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Cadatro de aluguel", style: TextStyle(color: appColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appColors.white), 
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 300)).whenComplete(() => Navigator.pop(context));
        }),
        centerTitle: true,
      ),
      body: StreamBuilder<Rent>(
        initialData: Rent(),
        stream: createRentController.streamForm.stream,
        builder: (context, snapshot) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // formUser(context, snapshot.data!),
                    // const SizedBox(height: 100),
                    // buttonCreateUser(context ,snapshot.data!),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget formUser(BuildContext context, Book book){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        popMenuButtonClient(book),
        const SizedBox(height: 20),
        popMenuButtonBook(book)
      ],
    );
  }

   Widget popMenuButtonClient(Book book){
    return StreamBuilder<String>(
      initialData: "",
      stream: createRentController.streamPopMenuButton.stream,
      builder: (_, snapshot) {
        return PopupMenuButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: appColors.grey, borderRadius: BorderRadius.circular(10)),
            height: 40,
            width: double.maxFinite,
            child: Row(
              children:[
                const Icon(Icons.arrow_drop_down, color: appColors.white),
                const SizedBox(width: 5),
                Center(
                  child: Text("Selecione o usuário", style: const TextStyle(color: appColors.white)
                  )
                ),
              ],
            ),
          ),
          itemBuilder: (_) {
            return ["O mundo assombrado pelos demônios", "Beserk", "Naruto", "O mundo de sofia", "On the road"].map((e){
              return PopupMenuItem(
                child: Text(e.toUpperCase()),
                onTap: () {
                  createRentController.streamPopMenuButton.sink.add(e);
                },
              );
            }).toList();
          }, 
        );
      }
    );
  }

   Widget popMenuButtonBook(Book book){
    return StreamBuilder<String>(
      initialData: "",
      stream: createRentController.streamPopMenuButton.stream,
      builder: (_, snapshot) {
        return PopupMenuButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: appColors.grey, borderRadius: BorderRadius.circular(10)),
            height: 40,
            width: double.maxFinite,
            child: Row(
              children:[
                const Icon(Icons.arrow_drop_down, color: appColors.white),
                const SizedBox(width: 5),
                Center(
                  child: Text("Selecione o livro", style: const TextStyle(color: appColors.white)
                  )
                ),
              ],
            ),
          ),
          itemBuilder: (_) {
            return ["O mundo assombrado pelos demônios", "Beserk", "Naruto", "O mundo de sofia", "On the road"].map((e){
              return PopupMenuItem(
                child: Text(e.toUpperCase()),
                onTap: () {
                  createRentController.streamPopMenuButton.sink.add(e);
                },
              );
            }).toList();
          }, 
        );
      }
    );
  }

  Widget buttonCreateUser(BuildContext context, Book book){
    return InkWell(
      onTap: ()=> createRentController.validationForm(book, context),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}