import 'package:flutter/material.dart';

class InputTexto extends StatefulWidget {
  final String label;
  final String hintLabel;
  final TextInputType inputTipo;
  final bool ehOculto;
  final TextEditingController? controller;
  final void Function(DateTime)? onDateSelected;

  const InputTexto({
    super.key,
    required this.label,
    required this.hintLabel,
    this.inputTipo = TextInputType.text,
    this.ehOculto = false,
    this.controller,
    this.onDateSelected,
  });

  @override
  State<InputTexto> createState() => _InputTextoState();
}

class _InputTextoState extends State<InputTexto> {
  String? _displayText;
  bool mostrar = false;

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
        color: Theme.of(context).colorScheme.surface,
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
                          "${dataEscolhida.year.toString().padLeft(4, '0')}/"
                          "${dataEscolhida.month.toString().padLeft(2, '0')}/"
                          "${dataEscolhida.day.toString().padLeft(2, '0')}";
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
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              )
              : TextFormField(
                keyboardType: widget.inputTipo,
                controller: widget.controller,
                obscureText: widget.ehOculto ? !mostrar : false,
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  hintText: widget.hintLabel,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  suffixIcon:
                      widget.ehOculto
                          ? IconButton(
                            onPressed:
                                () => setState(() {
                                  mostrar = !mostrar;
                                }),
                            icon:
                                mostrar
                                    ? Icon(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                      Icons.remove_red_eye_outlined,
                                    )
                                    : Icon(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                      Icons.remove_red_eye,
                                    ),
                          )
                          : null,
                ),
              ),
    );
  }
}
