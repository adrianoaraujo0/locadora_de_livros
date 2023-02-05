import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locadora_de_livros/model/client.dart';
import 'package:locadora_de_livros/ui/create_client/create_client_controller.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';

class CreateClientPage extends StatelessWidget {
  CreateClientPage({super.key});

  CreateUserController createUserController = CreateUserController();
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.purple,
        title: const Text("CADASTRO DE CLIENTE", style: TextStyle(color: appColors.white)),
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
        stream: createUserController.streamForm.stream,
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

  Widget formUser(BuildContext context, Client client){
    return  Form(
      key: createUserController.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Nome do usuário", suffixIcon: Icon(Icons.person)),
            controller: createUserController.nameController,
            onChanged: (value) => client.name = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Email do usuário", suffixIcon: Icon(Icons.email)),
            controller: createUserController.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => client.email = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Cpf do usuário", suffixIcon: Icon(Icons.wysiwyg)),
            controller: createUserController.cpfController,
            keyboardType: TextInputType.number,
            inputFormatters: [createUserController.cpfMask],
            onChanged: (value) => client.cpf = value,
          ),
          const SizedBox(height: 20),
          textFormFieldDateAndPosition(context, client),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Nome de login", suffixIcon: Icon(Icons.person)),
            controller: createUserController.usernameController,
            onChanged: (value) => client.userName = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(hintText: "Senha do usuário", suffixIcon: Icon(Icons.lock)),
            controller: createUserController.passwordController,
            onChanged: (value) => client.password = value,
          ),
          const SizedBox(height: 20),
          addImage(client)
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
                client.birthDate = createUserController.convertStringToDateTime(value);
              }
            },
            controller: createUserController.birthDateController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [createUserController.birthDateMask],
              decoration: const InputDecoration(hintText: "Data de nascimento", suffixIcon: Icon(Icons.date_range)),
          ),
        ),
       popMenuButtonPosition(client),
      ],
    );
  }


  Widget popMenuButtonPosition(Client client){
    return StreamBuilder<String?>(
      stream: createUserController.streamPopMenuButtonPosition.stream,
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
                client.position = "ADMIN";
                createUserController.streamPopMenuButtonPosition.sink.add("Admin");
              }), child: const  Text('Administrador')),
              PopupMenuItem(onTap: (() {
                client.position = "PEOPLE";
                createUserController.streamPopMenuButtonPosition.sink.add("Cliente");
              }), child: const Text('Cliente')),
            ];
          }, 
        );
      }
    );
  }

  Widget addImage(Client client){
    return StreamBuilder<bool>(
      stream: createUserController.streamAddImage.stream,
      initialData: false,
      builder: (context, snapshot) {
        if(snapshot.data == false){
          return InkWell(
            onTap: () async{
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                client.profilePicture = image.path;
                createUserController.streamAddImage.sink.add(true);
              }
            } ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(Icons.image, color: appColors.grey, size: 45),
                SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text("Adicione uma foto", style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          );
        }else{
          return InkWell(
            onTap: () async{
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                client.profilePicture = image.path;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(Icons.image, color: appColors.green, size: 45),
                SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text("Foto adicionada", style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          );
        }
      }, 
    );
  }

  Widget buttonCreateUser(BuildContext context, Client client){
    return InkWell(
      onTap: ()=> createUserController.validationForm(client, context),
      child: Container(
        height: 50,
        width: double.maxFinite * 0.8,
        decoration:  BoxDecoration(color: appColors.purple, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Cadastrar", style: TextStyle(color: appColors.white, fontSize: 20))),
      ),
    );
  }
}