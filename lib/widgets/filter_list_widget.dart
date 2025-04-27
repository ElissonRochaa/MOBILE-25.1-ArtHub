import 'package:flutter/material.dart';

class FilterListWidget extends StatelessWidget {
  const FilterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbVisibility: WidgetStatePropertyAll(false),
        radius: Radius.circular(20),
        thickness: WidgetStatePropertyAll(5),
        thumbColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
        mainAxisMargin: 8,
      ),
      child:
        Scrollbar(
          child: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child:SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 8, right: 5),
              child: Row(
                children: [
                  SingleItemFilterWidget("Todos"),
                  SingleItemFilterWidget("Poemas"),
                  SingleItemFilterWidget("Pinturas"),
                  SingleItemFilterWidget("Músicas"),
                  SingleItemFilterWidget("Desenhos"),
                  SingleItemFilterWidget("Esculturas"),
                ],
              ),
            ),
          )
        ),
    );
  }
}

class SingleItemFilterWidget extends StatefulWidget {
  final String name;
  const SingleItemFilterWidget(this.name, {super.key});

  @override
  State<SingleItemFilterWidget> createState() => _SingleItemFilterWidgetState();
}

class _SingleItemFilterWidgetState extends State<SingleItemFilterWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child:
        Container(
          height: 35,
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.only(left: 3, right: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Theme.of(context).colorScheme.tertiary : Colors.white,
              border: Border.all(
                color: isSelected ? Theme.of(context).colorScheme.tertiary : Color(0xFFCAC4D0),
                width: 1,
              )
          ),
          child: Row(
            children: [
              if (isSelected)
                Icon(
                  Icons.check,
                  size: 16,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              SizedBox(width: 4,),
              Center(
                child: Text(
                    widget.name,
                    style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onTertiary)),
              ),
            ],
          ),
        ),
    );
  }
}

