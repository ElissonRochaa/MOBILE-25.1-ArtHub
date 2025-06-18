import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:arthub/widgets/botao_estilizado_widget.dart';
import 'package:arthub/widgets/lista_filtros_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class TelaCriarPublicacao extends StatefulWidget {
  const TelaCriarPublicacao({super.key});

  @override
  State<TelaCriarPublicacao> createState() => _TelaCriarPublicacaoState();
}

class _TelaCriarPublicacaoState extends State<TelaCriarPublicacao> {
  File? _arquivoSelecionado;
  Uint8List? _arquivoBytes;
  String? _fileExtension;
  VideoPlayerController? _videoController;
  AudioPlayer? _audioPlayer;
  TextEditingController _textoController = TextEditingController();

  Future<void> _selecionarArquivo() async {
    try {
      FilePickerResult? arquivoEscolhido = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mp3'],
        withData: true,
      );

      if (arquivoEscolhido != null) {
        final file = arquivoEscolhido.files.single;
        _fileExtension = file.extension?.toLowerCase();

        // Pra Limpar controladores antigos
        if (_videoController != null) {
          await _videoController!.dispose();
          _videoController = null;
        }
        if (_audioPlayer != null) {
          await _audioPlayer!.dispose();
          _audioPlayer = null;
        }

        if (kIsWeb) {
          _arquivoBytes = file.bytes;
          _arquivoSelecionado = null;
        } else {
          _arquivoSelecionado = File(file.path!);
          _arquivoBytes = await _arquivoSelecionado!.readAsBytes();
        }

        // Pra inicializar vídeo se for mp4
        if (_fileExtension == 'mp4') {
          if (kIsWeb) {
            final dataUrl =
                'data:video/mp4;base64,${base64Encode(_arquivoBytes!)}';
            _videoController = VideoPlayerController.network(dataUrl);
          } else {
            _videoController = VideoPlayerController.file(_arquivoSelecionado!);
          }
          await _videoController!.initialize();
        }

        // Pra inicializar áudio se for mp3
        if (_fileExtension == 'mp3') {
          _audioPlayer = AudioPlayer();
          if (kIsWeb) {
            await _audioPlayer!.setAudioSource(
              AudioSource.uri(
                Uri.dataFromBytes(_arquivoBytes!, mimeType: 'audio/mp3'),
              ),
            );
          } else {
            await _audioPlayer!.setFilePath(_arquivoSelecionado!.path);
          }
        }

        setState(() {});
      }
    } catch (e) {
      print("Algo deu errado ao escolher um arquivo: $e");
    }
  }

  Widget _exibirArquivoSelecionado() {
    if (_fileExtension == null) return Container();
    if (['jpg', 'jpeg', 'png'].contains(_fileExtension)) {
      if (kIsWeb && _arquivoBytes != null) {
        return Image.memory(
          _arquivoBytes!,
          width: 374,
          height: 374,
          fit: BoxFit.cover,
        );
      } else if (!kIsWeb && _arquivoSelecionado != null) {
        return Image.file(
          _arquivoSelecionado!,
          width: 374,
          height: 374,
          fit: BoxFit.cover,
        );
      } else {
        return Center(child: Text('Imagem não encontrada'));
      }
    } else if (_fileExtension == 'mp4') {
      if (_videoController == null || !_videoController!.value.isInitialized) {
        return Center(child: CircularProgressIndicator());
      }
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          VideoProgressIndicator(_videoController!, allowScrubbing: true),
          IconButton(
            icon: Icon(
              _videoController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              setState(() {
                _videoController!.value.isPlaying
                    ? _videoController!.pause()
                    : _videoController!.play();
              });
            },
          ),
        ],
      );
    } else if (_fileExtension == 'mp3') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.audiotrack, size: 60, color: Colors.grey[700]),
          SizedBox(height: 10),
          Text('Áudio selecionado', style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  if (_audioPlayer != null) {
                    await _audioPlayer!.play();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () async {
                  await _audioPlayer?.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () async {
                  await _audioPlayer?.stop();
                },
              ),
            ],
          ),
        ],
      );
    } else {
      return Center(child: Text('Arquivo não suportado'));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer?.dispose();
    _textoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Criar Publicação',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            // Aqui o carrossel de categorias:
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Em quais categorias essa publicação se encaixa?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ListaFiltrosWidget(),
            SizedBox(height: 5),
            // Campo para colocar o título da publicação
            _input('Qual o título da publicação?'),
            SizedBox(height: 15),
            // Campo para texto ou mídia
            Container(
              height: 374,
              width: 374,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child:
                    (_fileExtension != null)
                        ? GestureDetector(
                          onTap: _selecionarArquivo,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _exibirArquivoSelecionado(),
                          ),
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Escreva um texto ou selecione uma mídia:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: _selecionarArquivo,
                                  icon: Icon(Icons.add, size: 45),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: TextFormField(
                                controller: _textoController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Digite seu texto aqui...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
            SizedBox(height: 15),
            _input('Qual a legenda da publicação?'),
            SizedBox(height: 25),
            BotaoEstilizadoWidget(
              funcao: () {
                print('Publicação foi criada');
                print('Texto: ${_textoController.text}');
                print('Arquivo: $_fileExtension');
              },
              texto: 'Compartilhar Publicação',
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String texto) {
    return Container(
      width: MediaQuery.of(context).size.width - 54,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Color(0xFFCAC4D0)),
      ),
      child: TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          hintText: texto,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
