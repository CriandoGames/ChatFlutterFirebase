import 'package:firebaseteste/model/abas/AbasContatos.dart';
import 'package:firebaseteste/model/abas/AbasConversas.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    //_recuperarDados();

    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: <Widget>[Tab(text: "Conversas"), Tab(text: "Contatos")],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          AbasConversas(),
          AbasContatos(),
        ],
      ),
    );
  }
}
