import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main2() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firestore db = Firestore.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;

  // //Criando Usuario com Login e senha
  // String email = "carloscastrogames@gmail.com";
  // String senha = "123456";

  // auth.createUserWithEmailAndPassword(email: email, password: senha).then((firebaseUser) {
  //   print("Sucesso " + firebaseUser.user.email);
  // }).catchError((erro)
  // {
  //   print("Sucesso " + erro.toString());
  // });

  // auth.signOut();

  // auth.signInWithEmailAndPassword(
  // email: email,
  //  password: senha).then((value){
  //   print("Sucesso " + value.user.email);
  //  }).catchError((erro)
  //  {
  //     print("Sucesso " + erro.toString());
  //  });

  // FirebaseUser usuarioAtual = await auth.currentUser();
  // if (usuarioAtual != null) {
  //   print("Sucesso " + usuarioAtual.email);
  // } else {
  //   print("erro");
  // }

  //

  // db.collection("usuarios").document("002").setData({
  ////  "nome": "Lala Castro3",
 //   "idade": "21",
  //});

  //Pega dados automaticos do banco
  /*db.collection("usuarios").snapshots().listen((event) 
  { 
    for(DocumentSnapshot item in event.documents)
    {
      var dados = item.data;
      print("Dados :" + dados["nome"] + " -" + dados["idade"]);
    }
  });*/

  //Filtros

  //QuerySnapshot querySnapshot = await db.collection("usuarios")
  //.where("nome", isEqualTo: "Carlos")
  //.where("idade", isEqualTo: 21)
  //.where("idade", isGreaterThan: 21)
  //.orderBy("idade", descending: true)
  //.orderBy("nome", descending: true)
  //.limit(1)
  // .where("nome", isGreaterThan: "C")
  // .where("nome", isLessThan: "L")
  //.getDocuments();

  // for(DocumentSnapshot item in querySnapshot.documents)
  // {

  //   var dados = item.data;
  //   print("Dados :" + dados["nome"] + " -" + dados["idade"]);

  // }

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ImagePicker picker = ImagePicker();
  File _image;
  String _statusUpload = "Upload não iniciado";
  String url;

  Future _recuperarImage(bool daCamera) async {
    File imgSelecionada;

    if (daCamera) {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      imgSelecionada = File(pickedFile.path);
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      imgSelecionada = File(pickedFile.path);
    }

    setState(() {
      _image = imgSelecionada;
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz.child("Fotos").child("foto1.jpg");

    //Fazer Upload da imagem
    StorageUploadTask task = arquivo.putFile(_image);

    //Controlar progresso do Uplaoad
    task.events.listen((event) {
      if (event.type == StorageTaskEventType.progress) {
        setState(() {
          _statusUpload = "Progresso";
        });
      } else if (event.type == StorageTaskEventType.success) {
        setState(() {
          _statusUpload = "Upload Sucess";
        });
      }
    });

    //Recupera URL da Imagem
    task.onComplete.then((StorageTaskSnapshot value) {
      _recuperaUrlImagem(value);
    });
  }

  _recuperaUrlImagem(StorageTaskSnapshot value) async {
    String url = await value.ref.getDownloadURL();
    print(url);
    setState(() {
      this.url = url;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar Imagem"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_statusUpload),
          RaisedButton(
            child: Text("Camera"),
            onPressed: () {
              _recuperarImage(true);
            },
          ),
          RaisedButton(
            child: Text("Galeria"),
            onPressed: () {
              _recuperarImage(false);
            },
          ),
          _image == null ? Container() : Image.file(_image,width: 50,height: 50,),
          _image == null
              ? Container()
              : RaisedButton(
                  child: Text("Upload"),
                  onPressed: () {
                    _uploadImagem();
                  },
                ),
                url != null ? Image.network(url,width: 50,height: 50,) : Container(),
        ],
      ),
    );
  }
}
