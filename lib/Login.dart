import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseteste/Screen/Home/Home.dart';
import 'package:flutter/material.dart';

import 'Screen/Cadastro/Cadastro.dart';
import 'model/Usuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      if (email.length > 6 && email.contains("@")) {
        if (senha.isNotEmpty) {
          Usuario usuario = Usuario();
          usuario.email = email;
          usuario.senha = senha;

          _logIn(usuario);
        } else {
          print("Senha Invalida");
        }
      } else {
        print("Email Invalido");
      }
    } catch (e) {}
  }

  _logIn(Usuario user) {
    FirebaseAuth db = FirebaseAuth.instance;

    db
        .signInWithEmailAndPassword(
      email: user.email,
      password: user.senha,
    )
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    }).catchError((erro) {
      print("Erro " + erro.toString());
    });
  }

  Future checkUserLogIn() async {
    FirebaseAuth db = FirebaseAuth.instance;
    FirebaseUser userCurrent = await db.currentUser();

    if (userCurrent != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    }
  }

  @override
  void initState() {
     checkUserLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/image/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: _controllerSenha,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 10,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contex) => Cadastro()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
