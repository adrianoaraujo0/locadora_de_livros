import 'package:flutter/material.dart';
import 'package:locadora_de_livros/ui/create_user/create_user_page.dart';
import 'package:locadora_de_livros/ui/list_users/users_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class ListUserPage extends StatelessWidget {
  ListUserPage({super.key});

  final UsersController usersController = UsersController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.white,
        title: const Text("USUÁRIOS", style: TextStyle(color: appColors.black)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: appColors.black), onPressed: ()=> Navigator.pop(context)),
        centerTitle: true,
      ),
      body: Stack(
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
          Positioned(bottom: 0, right: 0, child: addButton(context))
        ],
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

  Widget listViewUsers(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder:(context, index) {
          return itemListViewUsers(index);
        }, 
      ),
    );
  }

  Widget itemListViewUsers(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: appColors.purple),
            child: Center(child: Text("$index", style: const TextStyle(color: appColors.white))),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Adriano Araújo", style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                Text("adriano.amedeiros@hotmail.com", style: TextStyle(fontSize: 15)),
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
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserPage())),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(65)),
          color: appColors.purple,
        ),
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

  //nome, cidade, end, email
  Widget createUser(BuildContext context){
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
              Expanded(
                child: formUser()
              ),
              buttonCreateUser()
              ]
            ),
          ),
        ),
      ],
    );
  }

  Widget formUser(){
    return Form(
      key: usersController.formKey,
      child: Column(
        children: [
          textFieldForm("Nome do usuário", Icons.person,),
          const SizedBox(height: 20),
          textFieldForm("Cidade do usuário", Icons.location_city),
          const SizedBox(height: 20),
          textFieldForm("Endereço do usuário", Icons.home),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if(value != null && value.isEmpty){
                return "Preencha este campo";
              }else if(!value!.contains("@")){
                return "Email inválido.";
              }
            },
            decoration: const InputDecoration(hintText: "Email do usuário", suffixIcon: Icon(Icons.email))
          )
        ],
      ),
    );
  }

  Widget textFieldForm(String hintText, IconData icon){
    return TextFormField(
      onFieldSubmitted: (value) {
        usersController.formKey.currentState!.validate();
        usersController.myFocusNodes.nextFocus();
      },
      validator: (value) {
        if(value != null && value.isEmpty){
          return "Preencha este campo";
        }
        return null;
      },
      decoration: InputDecoration(hintText: hintText, suffixIcon: Icon(icon))
    );
  }

  Widget buttonCreateUser(){
    return InkWell(
      onTap: ()=> usersController.formKey.currentState!.validate(),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }

}