import 'package:flutter/material.dart';

class RodapeWidget extends StatelessWidget {
  const RodapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.all(5),
        child: Text('Desenvolvido por PLPM', textAlign: TextAlign.center),
      ),
    );
  }
}
