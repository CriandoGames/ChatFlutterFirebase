import 'package:flutter/material.dart';

import '../Conversa.dart';


class AbasConversas extends StatefulWidget {
  @override
  _AbasConversasState createState() => _AbasConversasState();
}

class _AbasConversasState extends State<AbasConversas> {
  
  
  List<Conversa> listaConversas =[
    Conversa("Carlos", "https://www.agritotal.com/files/image/10/10476/547dd47ac8ff9.jpg", "oi"),
    Conversa("Carlos", "https://www.agritotal.com/files/image/10/10476/547dd47ac8ff9.jpg", "oi"),
    Conversa("Carlos", "https://www.agritotal.com/files/image/10/10476/547dd47ac8ff9.jpg", "oi"),
    Conversa("Carlos", "https://www.agritotal.com/files/image/10/10476/547dd47ac8ff9.jpg", "oi"),

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (_,index){

      Conversa conversa = listaConversas[index];
      
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        leading: CircleAvatar(
          maxRadius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(conversa.photo),
        ),
        title: Text(conversa.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(conversa.mensagem, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
      

      });
  }
}