import 'package:flutter/material.dart';

class BarraPesquisaWidget extends StatelessWidget {
  const BarraPesquisaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 31,
          width: 246,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hannah.jpg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Colors.white, width: 0.9),
            borderRadius: BorderRadius.circular(70),
          ),
        ),
      ],
    );
  }
}
