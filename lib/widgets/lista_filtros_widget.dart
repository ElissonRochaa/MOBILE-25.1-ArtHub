import 'package:flutter/material.dart';

class ListaFiltrosWidget extends StatelessWidget {
  ListaFiltrosWidget({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbVisibility: WidgetStatePropertyAll(false),
        radius: Radius.circular(20),
        thickness: WidgetStatePropertyAll(5),
        thumbColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
        mainAxisMargin: 8,
      ),
      child: Scrollbar(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12, top: 10),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 8, right: 5),
            child: Row(
              children: [
                ItemFiltroWidget("Todos"),
                ItemFiltroWidget("Poemas"),
                ItemFiltroWidget("Pinturas"),
                ItemFiltroWidget("Músicas"),
                ItemFiltroWidget("Desenhos"),
                ItemFiltroWidget("Esculturas"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemFiltroWidget extends StatefulWidget {
  final String name;
  const ItemFiltroWidget(this.name, {super.key});

  @override
  State<ItemFiltroWidget> createState() => _ItemFiltroWidgetState();
}

class _ItemFiltroWidgetState extends State<ItemFiltroWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 35,
        margin: EdgeInsets.only(right: 4),
        padding: EdgeInsets.only(left: 3, right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isSelected
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.white,
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.tertiary
                    : Color(0xFFCAC4D0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (isSelected)
              Icon(
                Icons.check,
                size: 16,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            SizedBox(width: 4),
            Center(
              child: Text(
                widget.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
