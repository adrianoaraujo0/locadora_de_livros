import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/ui/crud_publishing_company/list_publishing_company_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListPublishingCompany extends StatefulWidget {
  ListPublishingCompany({super.key});

  @override
  State<ListPublishingCompany> createState() => _ListPublishingCompanyState();
}

class _ListPublishingCompanyState extends State<ListPublishingCompany> {
  final ListPublishingCompanyController listPublishingCompanyController = ListPublishingCompanyController();

  @override
  void initState() {
    super.initState();

    listPublishingCompanyController.initListPublishingCompanyController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("Editoras", style: TextStyle(color: appColors.white)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: appColors.white), onPressed: ()=> Navigator.pop(context)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(context: context, builder:(context) => bottomSheet(context)), 
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
                    listViewPublishingCompany(context)
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
        onChanged: (value)=> listPublishingCompanyController.search(value),
        controller: listPublishingCompanyController.searchController,
        decoration: InputDecoration(
          hintText: "Insira o nome da editora",
          focusColor: appColors.white,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ),
      )
    );
  }

  Widget listViewPublishingCompany(BuildContext context){
    return StreamBuilder<List<PublishingCompany>>(
      initialData: const [],
      stream: listPublishingCompanyController.streamPublishingCompany.stream,
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.data!.isEmpty){
          return const Center(child: Text("Nenhum editora foi cadastrada.", style: TextStyle(fontSize: 25)));
        }else{
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder:(context, index) {
                return itemListViewPublishingCompany(snapshot.data![index], index);
              }, 
            ),
          );
        }
      }
    );
  }

  Widget itemListViewPublishingCompany(PublishingCompany publishingCompany, int index){
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
              children: [
                Text( "${publishingCompany.name}", style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          // const Icon(Icons.edit, color: appColors.grey),
          const SizedBox(width: 10),
          // const Icon(Icons.delete, color: appColors.red)
        ]
      ),
    );
  }

  Widget bottomSheet(BuildContext context){
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: listPublishingCompanyController.formKey,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Nome da editora", suffixIcon: Icon(Icons.apartment)),
                  controller: listPublishingCompanyController.publishingCompanyController,
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Nome da editora vazio.";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
            ),
            buttonCreatePublishingCompany(context)
          ],
        ),
      ),
    );
  }

  Widget buttonCreatePublishingCompany(BuildContext context){
    return InkWell(
      onTap: ()=> listPublishingCompanyController.validationForm(context),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}