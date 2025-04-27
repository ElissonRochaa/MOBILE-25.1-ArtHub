import 'package:arthub/widgets/filter_list_widget.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("ArtHub"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
          child: Column(
            children: [
              FilterListWidget(),
            ],
          )
        ),
    );
  }
}
