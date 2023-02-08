import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/ui/create_book/create_book_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

// ignore: must_be_immutable
class CreateBookPage extends StatefulWidget {
  CreateBookPage({super.key});

  @override
  State<CreateBookPage> createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  CreateBookController createBookController = CreateBookController();

  @override
  void initState() {
    super.initState();

    createBookController.initPageCreateBook();
  }

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
    return  Form(
      key: createBookController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            controller: createBookController.titleController,
            decoration: const InputDecoration(hintText: "Título do livro", suffixIcon: Icon(Icons.book)),
            onChanged: (value) => book.title = value,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Título vazio";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: createBookController.authorController,
            decoration: const InputDecoration(hintText: "Autor do livro", suffixIcon: Icon(Icons.person)),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => book.author = value,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Título vazio";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: createBookController.dateController,
              onChanged: (value) {
                if(value.length == 10){
                  book.releaseDate = createBookController.convertStringToDateTime(value);
                }
              },
              keyboardType: TextInputType.datetime,
              inputFormatters: [createBookController.releaseDateMask],
                decoration: const InputDecoration(hintText: "Data de lançamento", suffixIcon: Icon(Icons.date_range)),
              validator: (value) {
              if(value == null || value.isEmpty){
                return "Data vazia";
              }else if(value.length < 10){
                return "Insira uma data válida";
              }else{
                return null;
              }
            },
            ),
          const SizedBox(height: 20),
          TextFormField(
            controller: createBookController.quantityController,
            decoration: const InputDecoration(hintText: "Quantidade", suffixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if(value.isNotEmpty){
                book.quantity = int.parse(value);
              }else{
                book.quantity = null;
              }
            },
            validator: (value){
              if(value == null || value.isEmpty){
                return "Insira um valor";
              }else if(int.parse(value) < 5){
                return "A quantidade não pode ser menor que 5.";
              }
            },
          ),
          const SizedBox(height: 20),
          popMenuButtonPosition(book)
        ],
      ),
    );
  }

   Widget popMenuButtonPosition(Book book){
    return StreamBuilder<List<PublishingCompany>>(
      initialData: null,
      stream: createBookController.streamPopMenuButtonPublishingCompanies.stream,
      builder: (_, snapshot) {
        return PopupMenuButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: appColors.grey, borderRadius: BorderRadius.circular(10)),
            height: 40,
            width: 200,
            child: Row(
              children:[
                const Icon(Icons.arrow_drop_down, color: appColors.white),
                const SizedBox(width: 5), 
                Center(
                  child: streamBuilderTextPopMenuButtonPublishingCompany()
                ),
              ],
            ),
          ),
          itemBuilder: (_) {
            return createBookController.publishingCompanies.map((publishingCompany){
              return PopupMenuItem(
                child: Text(publishingCompany.name!.toUpperCase()),
                onTap: () {
                  book.publishingCompanyId = publishingCompany.id;
                  createBookController.streamTextPopMenuButtonPublishingCompanies.sink.add(publishingCompany.name!);
                  createBookController.streamForm.sink.add(book);
                },
              );
            }).toList();
          }, 
        );
      }
    );
  }

  Widget streamBuilderTextPopMenuButtonPublishingCompany(){
    return StreamBuilder<String>(
      initialData: "Editoras",
      stream: createBookController.streamTextPopMenuButtonPublishingCompanies.stream,
      builder: (context, snapshot) => Text(snapshot.data??"Editoras", style: const TextStyle(color: appColors.white)),
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