import 'package:curi_autos_app/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controllers/nf_controller.dart';

class ItemWidget extends StatefulWidget {
  final TextEditingController description;
  final TextEditingController price;
  final TextEditingController qtd;
  final double total;
  final Function()? onDelete;
  final Function()? onChanged;
  const ItemWidget({
    Key? key,
    required this.description,
    required this.qtd,
    required this.price,
    required this.onChanged,
    required this.onDelete,
    required this.total,
  }) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NfController>(context);

    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: Text(
                  formatter.format(
                    int.parse(widget.qtd.text == '' ? '0' : widget.qtd.text) *
                        double.parse(
                          widget.price.text
                              .replaceAll('R\$', '')
                              .replaceAll('.', '')
                              .replaceAll(',', '.'),
                        ),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * 0.005),
                    child: SizedBox(
                      width: mediaQuery.width * 0.08,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Qtd',
                        ),
                        controller: widget.qtd,
                        onChanged: (value) {
                          controller.gettotalNF(controller.itens);
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.width * 0.035),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: mediaQuery.width * 0.005,
                      left: mediaQuery.width * 0.015,
                    ),
                    child: SizedBox(
                      width: mediaQuery.width * 0.55,
                      child: TextFormField(
                        minLines: 1,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                        ),
                        controller: widget.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.width * 0.035),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * 0.005),
                    child: SizedBox(
                      width: mediaQuery.width * 0.2,
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Preço',
                        ),
                        onChanged: (value) {
                          controller.gettotalNF(controller.itens);
                          setState(() {});
                        },
                        controller: widget.price,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: mediaQuery.width * 0.035),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.width * 0.1,
                    child: IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
