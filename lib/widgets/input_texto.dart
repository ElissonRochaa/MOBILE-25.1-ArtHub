import 'package:flutter/material.dart';

class InputTexto extends StatefulWidget {
  final String label;
  final String hintLabel;
  final TextInputType inputTipo;
  final void Function(DateTime)? onDateSelected;

  const InputTexto({
    super.key,
    required this.label,
    required this.hintLabel,
    this.inputTipo = TextInputType.text,
    this.onDateSelected,
  });

  @override
  State<InputTexto> createState() => _InputTextoState();
}

class _InputTextoState extends State<InputTexto> {
  String? _displayText;

  @override
  void initState() {
    super.initState();
    _displayText = widget.hintLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 346,
      height: 79,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(10, 10, 10, 0.3),
            offset: const Offset(6, 6),
            blurRadius: 2.0,
          ),
        ],
      ),
      child:
          widget.inputTipo == TextInputType.datetime
              ? GestureDetector(
                onTap: () async {
                  final DateTime? dataEscolhida = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (dataEscolhida != null) {
                    setState(() {
                      _displayText =
                          "${dataEscolhida.day}/${dataEscolhida.month}/${dataEscolhida.year}";
                    });
                    if (widget.onDateSelected != null) {
                      widget.onDateSelected!(dataEscolhida);
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _displayText!,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              )
              : TextFormField(
                keyboardType: widget.inputTipo,
                decoration: InputDecoration(
                  labelText: widget.label,
                  hintText: widget.hintLabel,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ),
    );
  }
}
