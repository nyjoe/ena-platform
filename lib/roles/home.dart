//import 'dart:math';

//import 'package:appli_ena/data/messages.dart';
import 'package:appli_ena/roles/login.dart';
import 'package:appli_ena/services/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<MyHomePage> {

  final User? user = Auth().currentUser;
  //List<dynamic> couleurs = [0xff1C3D8F,0xff3678FF,0xffCD1719,0xffFDE507];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1c3d8f),
        foregroundColor: Colors.white,
        title:Text("${(user?.email)}", style: TextStyle(fontFamily: 'EB Garamond'),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const LoginPage(title: "Connexion",)
                )
              );
            }, 
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: (){
              Auth().logOut();
            }, 
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Text("Bienvenue sur votre tableau de bord", 
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            color: Color(0xff1c3d8f),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //  ListView.builder(
      //   itemCount: messages.length,
      //   itemBuilder: (context, index){
      //     return ListTile(
      //       onTap: (){
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             content: Text("Vous avez cliqué sur le mail numéro ${(index+1)}"),
      //             behavior: SnackBarBehavior.floating,
      //             backgroundColor: Colors.indigo,
      //             showCloseIcon: true,
      //           )
      //         );
      //       },
      //       shape: const Border(
      //         bottom: BorderSide(color: Colors.grey, width: 0.3)
      //       ),
      //       isThreeLine: true,
      //       leading: CircleAvatar(
      //         radius: 25,
      //         backgroundColor: Colors.primaries[
      //           Random().nextInt(Colors.primaries.length)
      //         ].shade200,
      //         foregroundColor: Colors.black,
      //         child: Text(messages[index]["title"]![0]),
      //       ),
      //       title: Text(messages[index]["title"]!),
      //       subtitle: Text(
      //         messages[index]["body"]!,
      //         overflow: TextOverflow.ellipsis,
      //         maxLines: 2,
      //       ),
      //       trailing: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Text(
      //             TimeOfDay.fromDateTime(
      //               DateTime.parse(messages[index]["date"].toString())
      //             ).format(context)
      //           ),
      //           Icon(Icons.star_outline)
      //         ],
      //       ),
      //     );
      //   }
      // ),

      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              tileColor: Color(0xff1c3d8f),
              title: Text("Menu Principal", style: TextStyle(
                color: Color(0xfffde507),
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.all_inbox),
              title: Text("Sous-menu 1"),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Sous-menu 2"),
            ),
            const ListTile(
              leading: Icon(Icons.group_outlined),
              title: Text("Sous-menu 3"),
            ),
            const ListTile(
              leading: Icon(Icons.discount_outlined),
              title: Text("Sous menu 4"),
              trailing: Chip(
                backgroundColor: Colors.lightGreen,
                label: Text("99+")
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.star_outline),
              title: Text("Sous-menu 5"),
            ),
            const ListTile(
              leading: Icon(Icons.label_important_outline),
              title: Text("Sous-menu 6"),
              trailing: Text("4"),
            ),
            const ListTile(
              leading: Icon(Icons.send),
              title: Text("Sous-menu 7"),
            ),
            // const ListTile(
            //   leading: Icon(Icons.schedule_send_outlined),
            //   title: Text("Schedule"),
            // ),
            // const ListTile(
            //   leading: Icon(Icons.outbox_outlined),
            //   title: Text("Outbox"),
            // ),
            const ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Drafts"),
              trailing: Text("99+"),
            ),
            const ListTile(
              leading: Icon(Icons.mail_outlined),
              title: Text("All mail"),
            ),
            // const ListTile(
            //   leading: Icon(Icons.inbox),
            //   title: Text("Primary"),
            // ),
            // const ListTile(
            //   leading: Icon(Icons.info_outline),
            //   title: Text("Spam"),
            // ),
            const ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text("Trash"),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff1c3d8f),
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const LoginPage(title: "Connexion",)
            )
          );
        },
        child: Icon(
          Icons.edit,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}