import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locadora_de_livros/components/drawerComponents.dart';
import 'package:locadora_de_livros/utils/app_colors.dart';
import 'package:locadora_de_livros/widgets/appBarGlobal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false ,home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: const PreferredSize(preferredSize: Size.fromHeight(40), child: AppBarGlobal()),
      body: Container( 
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        color: appColors.purple,
        child: Column(
          children: [
           menu(),
           dashboard(),
          ],
        ),
      ),
    );
  }

  Widget menu(){
    return Expanded(
      child: Container(
        width:  MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cards("Usuários",  appColors.blue),
                const SizedBox(width: 10),
                cards("Livros",  appColors.green)
              ],
            ),
            const SizedBox(height: 20),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cards("Aluguéis",  appColors.yellow),
                const SizedBox(width: 10),
                cards("Editoras",  appColors.red),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget cards(String name, Color color){
    return Container(
      height: 120,
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: color, 
        borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("0", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            ],
          ),

        ],
      ),
    );
  }

  Widget dashboard(){
    return  Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      height: (MediaQuery.of(context).size.height / 2) - MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text("Livros mais alugados", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }
}
