import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/formatters.dart';

class ClientWidget extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController contact;
  final TextEditingController veiculo;
  final TextEditingController placa;
  final TextEditingController km;
  const ClientWidget({
    Key? key,
    required this.name,
    required this.contact,
    required this.veiculo,
    required this.placa,
    required this.km,
  }) : super(key: key);

  @override
  State<ClientWidget> createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SizedBox(
                width: mediaQuery.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  controller: widget.name,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(
                      color: Colors.black, fontSize: mediaQuery.width * 0.035),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SizedBox(
                width: mediaQuery.width * 0.4,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contato',
                  ),
                  controller: widget.contact,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelephoneMask(),
                  ],
                  onChanged: (value) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.black, fontSize: mediaQuery.width * 0.035),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: SizedBox(
                    width: mediaQuery.width * 0.35,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Veiculo',
                      ),
                      controller: widget.veiculo,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {});
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQuery.width * 0.035),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: SizedBox(
                    width: mediaQuery.width * 0.17,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Placa',
                      ),
                      controller: widget.placa,
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQuery.width * 0.035),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: SizedBox(
                    width: mediaQuery.width * 0.2,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'km',
                      ),
                      controller: widget.km,
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: mediaQuery.width * 0.035),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
