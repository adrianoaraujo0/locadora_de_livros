import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/ui/create_client/create_client_controller.dart';
import 'package:locadora_de_livros/ui/update_client/update_client_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class UpdateClientPage extends StatefulWidget {
  UpdateClientPage({required this.idClient, super.key});
  String idClient;

  @override
  State<UpdateClientPage> createState() => _UpdateClientPageState();
}

class _UpdateClientPageState extends State<UpdateClientPage> {

  UpdateClientController updateClientController = UpdateClientController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    updateClientController.initUpdatePage(widget.idClient);    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("EDITAR CLIENTE", style: TextStyle(color: appColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appColors.white), 
          onPressed: ()async {
            FocusScope.of(context).unfocus();
            await Future.delayed( const Duration(milliseconds: 300)).whenComplete(() => Navigator.pop(context));
          }
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Client>(
        initialData: Client(),
        stream: updateClientController.streamForm.stream,
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

    Widget addImage(Client client){
    return StreamBuilder<String>(
      stream: updateClientController.streamAddImage.stream,
      initialData: "",
      builder: (context, snapshot) {
        if(snapshot.data == null || snapshot.data!.isEmpty){
          return InkWell(
            onTap: () async{
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                client.profilePicture = image.path;
                updateClientController.streamAddImage.sink.add(image.path);
              }
            } ,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle,),
              height: 150,
              width: 150,
              child: Image.asset("assets/images/user.png"),
            ),
          );
        }else{
          return InkWell(
            onTap: () async{
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                client.profilePicture = image.path;
                updateClientController.streamAddImage.sink.add(image.path);
              }
            },
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: FileImage(File(snapshot.data!)), fit: BoxFit.fill)
              ),
            )
          );
        }
      }, 
    );
  }

  Widget formUser(BuildContext context, Client client){
    return  Form(
      key: updateClientController.formKey,
      child: Column(
        children: [
          // addImage(client),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Nome do usuário", suffixIcon: Icon(Icons.person)),
            controller: updateClientController.nameController,
            onChanged: (value) => client.name = value,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Nome vazio.";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Email do usuário", suffixIcon: Icon(Icons.email)),
            controller: updateClientController.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => client.email = value,
              validator: (value) {
              if(value == null || value.isEmpty){
                return "Email vazio";
              }else if(!value.contains("@") || !value.contains(".com")){
                return "Email inválido.";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Cpf do usuário", suffixIcon: Icon(Icons.wysiwyg)),
            controller: updateClientController.cpfController,
            keyboardType: TextInputType.number,
            inputFormatters: [updateClientController.cpfMask],
            onChanged: (value) => client.cpf = value,
             validator: (value) {
              if(value == null || value.isEmpty){
                return "cpf vazio.";
              }else if(value.length < 14){
                return "cpf inválido.";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
           TextFormField(
            onChanged: (value) {
              if(value.length == 10){
                client.birthDate = updateClientController.convertStringToDateTime(value);
              }
            },
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Data vazia";
              }else if(value.length < 10){
                return "Insira uma data válida";
              }else{
                return null;
              }
            },
            controller: updateClientController.birthDateController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [updateClientController.birthDateMask],
              decoration: const InputDecoration(hintText: "Data de nascimento", suffixIcon: Icon(Icons.date_range)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Email de login", suffixIcon: Icon(Icons.person)),
            controller: updateClientController.usernameController,
            onChanged: (value) => client.userName = value,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Email de login vazio";
              }else if(!value.contains("@") || !value.contains(".com")){
                return "Email de login inválido.";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Senha do usuário", suffixIcon: Icon(Icons.lock)),
            controller: updateClientController.passwordController,
            onChanged: (value) => client.password = value,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Senha vazia";
              }else if(value.length < 6){
                return "A senha deve ter no mínimo 6 caracteres.";
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget textFormFieldDateAndPosition(BuildContext context, Client client){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: TextFormField(
            onChanged: (value) {
              if(value.length == 10){
                // client.birthDate = createUserController.convertStringToDateTime(value);
              }
            },
            controller: updateClientController.birthDateController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [updateClientController.birthDateMask],
              decoration: const InputDecoration(hintText: "Data de nascimento", suffixIcon: Icon(Icons.date_range)),
          ),
        ),
      ],
    );
  }

  Widget popMenuButtonPosition(Client client){
    return StreamBuilder<String>(
      stream: updateClientController.streamPopMenuButtonPosition.stream,
      builder: (context, snapshot) {
        return PopupMenuButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: appColors.grey, borderRadius: BorderRadius.circular(10)),
            height: 40,
            width: 90,
            child: Row(
              children:[
                const Icon(Icons.arrow_drop_down, color: appColors.white),
                const SizedBox(width: 5),
                Center(
                  child: Text( snapshot.data??"Cargo", style: const TextStyle(color: appColors.white))),
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(onTap: (() {
                client.position = "ADMINISTRADOR";
                updateClientController.streamPopMenuButtonPosition.sink.add("Admin");
              }), child: const  Text('Administrador')),
              PopupMenuItem(onTap: (() {
                client.position = "CLIENTE";
                updateClientController.streamPopMenuButtonPosition.sink.add("Cliente");
              }), child: const Text('Cliente')),
            ];
          }, 
        );
      }
    );
  }

  Widget buttonCreateUser(BuildContext context, Client client){
    return InkWell(
      onTap: ()=> updateClientController.validationForm(client, context),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Atualizar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}