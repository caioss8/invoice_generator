import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';

import '../../../core/params/params.dart';
import '../../../core/utils/formatters.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/share_document/share_nf_usecase.dart';

class NfController extends ChangeNotifier {
  final itens = <ItemEntity>[];

  String totalNF = '';

  final TextEditingController name = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController placa = TextEditingController();
  final TextEditingController veiculo = TextEditingController();
  final TextEditingController km = TextEditingController();

  final ShareDocumentUsecase shareDocumentUsecase;

  NfController(this.shareDocumentUsecase);

  Future<void> addItem() async {
    itens.add(
      ItemEntity(
        id: Random().nextInt(2424242424),
        qtd: TextEditingController(text: '1'),
        description: TextEditingController(),
        onDelete: () {},
        price: TextEditingController(text: 'R\$ 0,00'),
      ),
    );
    notifyListeners();
  }

  String totalItemPrice(ItemEntity item) {
    final value = int.parse(item.qtd.text == '' ? '0' : item.qtd.text) *
        double.parse(
          item.price.text
              .replaceAll('R\$', '')
              .replaceAll('.', '')
              .replaceAll(',', '.'),
        );

    return formatter.format(value);
  }

  Future<void> gettotalNF(List<ItemEntity> items) async {
    double value = 0.0;
    for (var item in items) {
      value += int.parse(item.qtd.text == '' ? '0' : item.qtd.text) *
          double.parse(
            item.price.text
                .replaceAll('R\$', '')
                .replaceAll('.', '')
                .replaceAll(',', '.'),
          );
    }
    totalNF = formatter.format(value);
    notfyListners();
  }

  Future<void> notfyListners() async {
    notifyListeners();
  }

  Future<void> delete(int id) async {
    itens.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> exportextPDF() async {
    final pdf = pw.Document();

    final logo = pw.MemoryImage(await _readImageData('curi_autos.png'));

    final textSyle = pw.TextStyle(
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
    );

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Column(children: [
            pw.Image(logo),
            pw.SizedBox(height: 10),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Center(
                child: pw.Text(
                  'ORDEM DE SERVIÇO',
                  style: pw.TextStyle(
                    fontSize: 23,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Nome: ${name.text}', style: textSyle),
                  pw.SizedBox(height: 10),
                  pw.Text('Contato: ${contact.text}', style: textSyle),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.Text('Veiculo: ${veiculo.text}', style: textSyle),
                      pw.SizedBox(width: 10),
                      pw.Text('Placa: ${placa.text}', style: textSyle),
                      pw.SizedBox(width: 10),
                      pw.Text('KM: ${km.text}', style: textSyle),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            pw.ListView.builder(
              itemCount: itens.length,
              itemBuilder: ((context, index) {
                final item = itens[index];
                return pw.Column(children: [
                  if (index == 0)
                    pw.Column(children: [
                      pw.Container(
                        width: double.infinity,
                        height: 2,
                        color: PdfColors.black,
                      ),
                      pw.SizedBox(height: 10),
                    ]),
                  if (index == 0)
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            width: 50,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Center(
                              child: pw.Text('Qtd', style: textSyle),
                            ),
                          ),
                          pw.Container(
                            width: 275,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Center(
                              child: pw.Text('Descrição', style: textSyle),
                            ),
                          ),
                          pw.Row(children: [
                            pw.Container(
                              width: 77.5,
                              padding: const pw.EdgeInsets.only(top: 2),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Center(
                                child: pw.Text(
                                  'Preço Unit.',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.only(top: 2),
                              width: 77.5,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Center(
                                child: pw.Text(
                                  'Preço Total',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 50,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Center(
                            child: pw.Text(item.qtd.text, style: textSyle),
                          ),
                        ),
                        pw.Container(
                          width: 275,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Center(
                            child:
                                pw.Text(item.description.text, style: textSyle),
                          ),
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 77.5,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Center(
                                child: pw.Text(
                                  totalItemPrice(item),
                                  style: textSyle,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 77.5,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Center(
                                child: pw.Text(
                                  totalItemPrice(item),
                                  style: textSyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  if (index == itens.length - 1)
                    pw.Column(children: [
                      pw.SizedBox(height: 10),
                      pw.Center(
                        child: pw.Text(
                          'TOTAL: $totalNF',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                ]);
              }),
            )
          ]),
        ],
      ),
    );

    final bytes = await pdf.save();

    final output = await getTemporaryDirectory();
    final file = await File(
            '${output.path}/ficha-curi-autos-${Random().nextInt(2424242424)}.pdf')
        .writeAsBytes(bytes);

    await shareDocumentUsecase.call(
      ShareDocumentParam(
        filesPath: {file.path},
        message: veiculo.text,
      ),
    );
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
