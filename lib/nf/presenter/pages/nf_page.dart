import 'package:curi_autos_app/nf/presenter/widgets/client_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/nf_controller.dart';
import '../widgets/item_widget.dart';

class NfPage extends StatefulWidget {
  const NfPage({Key? key}) : super(key: key);

  @override
  State<NfPage> createState() => _NfPageState();
}

class _NfPageState extends State<NfPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final controller = Provider.of<NfController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          'CURI AUTOS - ORDEM DE SERVIÇO',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: mediaQuery.width * 0.115,
            height: mediaQuery.width * 0.115,
            child: FloatingActionButton(
              child: const Icon(Icons.share),
              backgroundColor: Colors.grey,
              onPressed: () {
                controller.exportextPDF();
              },
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: mediaQuery.width * 0.115,
            height: mediaQuery.width * 0.115,
            child: FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              backgroundColor: Colors.grey,
              onPressed: () {
                controller.addItem();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'DADOS DO CLIENTE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            ClientWidget(
              name: controller.name,
              contact: controller.contact,
              veiculo: controller.veiculo,
              placa: controller.placa,
              km: controller.km,
            ),
            const SizedBox(height: 10),
            Container(color: Colors.black, width: double.infinity, height: 4),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'ORDEM DE SERVIÇO',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(color: Colors.black, width: double.infinity, height: 4),
            const SizedBox(height: 10),
            SizedBox(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.itens.length,
                itemBuilder: (ctx, index) {
                  final item = controller.itens[index];
                  return Column(
                    children: [
                      if (index != 0) const SizedBox(height: 10),
                      ItemWidget(
                        onChanged: () {
                          controller.notfyListners();
                        },
                        total: 0,
                        qtd: item.qtd,
                        description: item.description,
                        price: item.price,
                        onDelete: () async {
                          await controller.delete(item.id);
                        },
                      ),
                      if (index == controller.itens.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'VALOR TOTAL: ${controller.totalNF}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
