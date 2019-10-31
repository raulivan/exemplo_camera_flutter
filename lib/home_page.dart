import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nomeFocus = FocusNode();
  final _telefoneFocus = FocusNode();

  String caminho_foto;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Novo Contato"),
          centerTitle: true,
          backgroundColor: Colors.red),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Clicou no Action Button');

          if (_nomeController.text == null || _nomeController.text.isEmpty) {
            FocusScope.of(context).requestFocus(_nomeFocus);
          } else if (_telefoneController.text == null ||
              _telefoneController.text.isEmpty) {
            FocusScope.of(context).requestFocus(_telefoneFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: _retornaFoto(caminho_foto)),
                  )),
              onTap: () {
                print('Clicou na foto');
                ImagePicker.pickImage(source: ImageSource.camera).then((foto) {
                  if (foto == null) return;
                  setState(() {
                    caminho_foto = foto.path;
                  });
                });                
              },
            ),
            TextField(
              controller: _nomeController,
              focusNode: _nomeFocus,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }

  dynamic _retornaFoto(String caminho) {
    if (caminho == null || caminho.isEmpty) {
      return AssetImage('images/no_photo.png');
    } else {
      try {
        return FileImage(File(caminho));
      } catch (ex) {
        print(ex);
        return AssetImage('images/no_photo.png');
      }
    }
  }
}
