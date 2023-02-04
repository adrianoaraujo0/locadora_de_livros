import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
                  appColors.purple,
                  appColors.purple.withBlue(150),
                ],
              )
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSecondContainer(context),
                  ],
                ),
              ),
            ),
        )
      ),
    );
  }

  Widget buildSecondContainer(BuildContext context){
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColors.white),
      height: 751,
      width: 380,
      child: Center(child: Padding(padding: const EdgeInsets.all(20.0), child: buildForm(context))),
    );
  }

  Widget buildForm(BuildContext context){
    return Form(
      key: loginController.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text("Login", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: appColors.black)),
            const SizedBox(height: 50),
            TextFormField(
              controller: loginController.emailController,
              decoration: const InputDecoration( icon: Icon(Icons.email), hintText: "Insira seu email"),
              validator: (value) {
                if(value!.isEmpty || !value.contains("@") || !value.contains(".com")){
                  return "Email inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            StreamBuilder<bool>(
              initialData: false,
              stream: loginController.streamObscurePassword.stream,
              builder: (context, snapshot) {
                return TextFormField(
                  obscureText: snapshot.data!,
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    hintText: "Insira seu email", 
                    suffixIcon: IconButton(
                      onPressed: ()=> loginController.streamObscurePassword.sink.add(!snapshot.data!),
                      icon: snapshot.data == false ? const Icon(FontAwesomeIcons.eye) : const Icon(FontAwesomeIcons.eyeSlash)
                    )
                  ),
                  validator: (value) {
                    if(value!.isEmpty || value.length < 6){
                      return "Senha incorreta.";
                    }
                    return null;
                  },
                );
              }
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 137, vertical: 20)
              ),
              onPressed: (){ 
                loginController.validationForm(context);
              }, 
              child: const Text("Login"), 
            ),
            const SizedBox(height: 60),
           
          ],
        ),
      ),
    );
  }


  Widget buildTextField({required TextEditingController controller ,required IconData icon, required String hintText, bool obscure = false}){
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value!.isEmpty){
          return "Ops, você deixou esse campo vazio!";
        }
      },
      obscureText: obscure,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
      ),
    );
  }
}