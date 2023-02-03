import 'package:flutter/material.dart';
import 'package:locadora_de_livros/model/publishing_company.dart';
import 'package:locadora_de_livros/ui/crud_publishing_company/list_publishing_company_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListPublishingCompany extends StatelessWidget {
  ListPublishingCompany({super.key});

  final ListPublishingCompanyController listPublishingCompanyController = ListPublishingCompanyController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PublishingCompany>(
      initialData: PublishingCompany(),
      stream: listPublishingCompanyController.streamPublishingCompany.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appColors.purple,
            title: const Text("Editoras", style: TextStyle(color: appColors.white)),
            leading: IconButton(icon: const Icon(Icons.arrow_back, color: appColors.white), onPressed: ()=> Navigator.pop(context)),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context, builder:(context) => bottomSheet(context, snapshot.data!)
                ), 
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
    );
    }

  Widget searchWidget(){
    return Flexible(
      child: TextField(
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder:(context, index) {
          return itemListViewPublishingCompany(index);
        }, 
      ),
    );
  }

  Widget itemListViewPublishingCompany(int index){
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
                Text("Makron", style: TextStyle(fontSize: 20)),
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

  Widget bottomSheet(BuildContext context, PublishingCompany publishingCompany){
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
            buttonCreatePublishingCompany(context, publishingCompany)
          ],
        ),
      ),
    );
  }

  Widget buttonCreatePublishingCompany(BuildContext context, PublishingCompany publishingCompany){
    return InkWell(
      onTap: ()=> listPublishingCompanyController.validationForm(context, publishingCompany),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }

}