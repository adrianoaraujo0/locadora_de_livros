import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/book.dart';
import 'package:locadora_de_livros/model/rent.dart';
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
    createRentController.initCreateRentPage();
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formRent(snapshot.data!),
                  const  SizedBox(height: 100),
                  buttonCreateUser(context, snapshot.data!),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget formRent(Rent rent){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        popMenuButtonClient(rent),
        const SizedBox(height: 20),
        popMenuButtonBook(rent),
        const SizedBox(height: 20),
        dateButton(
          "Data de retirada: ${
              rent.loanDate != null
              ? createRentController.convertDateToString(rent.loanDate!)
              :"--/--/----"
            }",
           rent,
           isLoanDate: true
        ),
        const SizedBox(height: 20),
        dateButton(
          "Data de retirada: ${
              rent.returnDate != null
              ? createRentController.convertDateToString(rent.returnDate!)
              :"--/--/----"
            }",
           rent
        ),
        const SizedBox(height: 50),
        showInfoRent(),

      ]
    );
  }

  Widget dateButton(String name, Rent rent, {bool isLoanDate = false}){
    return InkWell(
      onTap: () async {
        if(isLoanDate){
          await createRentController.pickLoanDate(context, rent);
        }else{
          await createRentController.pickReturnDate(context, rent);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(color: appColors.grey, borderRadius: BorderRadius.circular(10)),
        height: 40,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(name, style: const TextStyle(color: appColors.white)),
            ),
             const Icon(Icons.arrow_drop_down, color: appColors.white),
          ],
        ),
      ),
    );
  }

  Widget showInfoRent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StreamBuilder<String?>(
              initialData: null,
              stream: createRentController.streamNameClient.stream,
              builder: (context, snapshot) => Expanded(child: Text("Usu??rio selecionado: ${snapshot.data??""}", style: const TextStyle(fontSize: 20)))
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            StreamBuilder<String?>(
              initialData: null,
              stream: createRentController.streamNameBook.stream,
              builder: (context, snapshot) => Expanded(child: Text("Livro selecionado: ${snapshot.data??""}", style: const TextStyle(fontSize: 20)))
            ),
          ],
        ),
      ],
    );
  }

   Widget popMenuButtonClient(Rent rent){
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Selecione o usu??rio", style: const TextStyle(color: appColors.white)
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: appColors.white),
              ],
            ),
          ),
          itemBuilder: (_) {
            return createRentController.clients.map((client){
              return PopupMenuItem(
                child: Text(client.name!),
                onTap: () {
                  rent.clientId = client.id;
                  createRentController.streamNameClient.sink.add(client.name!);
                  createRentController.streamForm.sink.add(rent);
                },
              );
            }).toList();
          }, 
        );
      }
    );
  }

   Widget popMenuButtonBook(Rent rent){
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Selecione o livro", style: TextStyle(color: appColors.white)
                  ),
                ),
                 Icon(Icons.arrow_drop_down, color: appColors.white),
              ],
            ),
          ),
          itemBuilder: (_) {
            return createRentController.books.map((book){
              return PopupMenuItem(
                child: Text(book.title!),
                onTap: () {
                   rent.bookId = book.id;
                  createRentController.streamNameBook.sink.add(book.title!);
                  createRentController.streamForm.sink.add(rent);
                },
              );
            }).toList();
          }, 
        );
      }
    );
  }

  Widget buttonCreateUser(BuildContext context, Rent rent){
    return InkWell(
      onTap: ()=> createRentController.validationForm(context, rent),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}