import 'dart:io';

import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TelaCriarPublicacao extends StatefulWidget {
  const TelaCriarPublicacao({super.key});

  @override
  State<TelaCriarPublicacao> createState() => _TelaCriarPublicacaoState();
}

class _TelaCriarPublicacaoState extends State<TelaCriarPublicacao> {
  File? _arquivoSelecionado;

  Future<void> _selecionarArquivo() async {
    try{
      FilePickerResult? arquivoEscolhido = await FilePicker.platform.pickFiles();

      if(arquivoEscolhido != null){
        setState(() {
          _arquivoSelecionado = File(arquivoEscolhido.files.single.path!);
        });
      }
    }
    catch(e){
      print("ALgo deu errado ao escolher um arquivo");
    }
  }
  
  Widget _input(String texto){
    return Container(
      width: MediaQuery.of(context).size.width - 54,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Color(0xFFCAC4D0)
          )
      ),
      child: TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          hintText: texto,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiary, fontSize: 15),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Criar Publicação',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            // Seletor de categorias
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Em quais categorias essa publicação se encaixa?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 5),
              child: ListaFiltrosWidget(),
            ),
            SizedBox(height: 5,),
            // Campo para colocar o título da publicação
            _input('Qual o título da publicação?'),
            SizedBox(height: 15,),
            Container(
              height: 374,
              width: 374,
              decoration: BoxDecoration(
                color: Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xFFB4B4B4),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: _arquivoSelecionado != null ?
                  Image.file(_arquivoSelecionado!, fit: BoxFit.cover,) :
                  Center(
                    child: IconButton(
                        onPressed: _selecionarArquivo,
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          size: 45,
                        )
                    ),
                  )
                ),
              )
            ),
            SizedBox(height: 15,),
            _input('Qual a legenda da publicação?'),
            SizedBox(height: 25,),
            BotaoEstilizadoWidget(
              funcao: (){print('Publicação foi criada');},
              texto: 'Compartilhar Publicação',
            )
          ],
        ),
      ),
    );
  }
}

