import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

// ignore: must_be_immutable
class CreateBookPage extends StatelessWidget {
  CreateBookPage({super.key});

  CreateBookController createBookController = CreateBookController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Cadatro de livro", style: TextStyle(color: appColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appColors.white), 
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 300)).whenComplete(() => Navigator.pop(context));
        }),
        centerTitle: true,
      ),
      body: StreamBuilder<Book>(
        initialData: Book(),
        stream: createBookController.streamForm.stream,
        builder: (context, snapshot) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    formUser(context, snapshot.data!),
                    const SizedBox(height: 100),
                    buttonCreateUser(context ,snapshot.data!),
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
      children: [
        TextFormField(
          decoration: const InputDecoration(hintText: "Título do livro", suffixIcon: Icon(Icons.book)),
          onChanged: (value) => book.title = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(hintText: "Autor do livro", suffixIcon: Icon(Icons.person)),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => book.author = value,
        ),
        const SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {
              if(value.length == 10){
                book.releaseDate = createBookController.convertStringToDateTime(value);
              }
            },
            keyboardType: TextInputType.datetime,
            inputFormatters: [createBookController.releaseDateMask],
              decoration: const InputDecoration(hintText: "Data de lançamento", suffixIcon: Icon(Icons.date_range)),
          ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(hintText: "Quantidade", suffixIcon: Icon(Icons.email)),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if(value.isNotEmpty){
              book.quantity = int.parse(value);
            }else{
              book.quantity = null;
            }
          },
        ),
      ],
    );
  }


  

 

  Widget buttonCreateUser(BuildContext context, Book book){
    return InkWell(
      onTap: ()=> createBookController.validationForm(book, context),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}