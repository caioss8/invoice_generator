import 'package:curi_autos_app/core/services/share/share_service.dart';
import 'package:curi_autos_app/nf/domain/usecases/share_document/share_nf_usecase.dart';
import 'package:curi_autos_app/nf/extenal/datasource/share_nf_datasource.dart';
import 'package:curi_autos_app/nf/infra/repositorys/share_nf_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nf/presenter/controllers/nf_controller.dart';
import 'nf/presenter/pages/nf_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NfController(
        const ShareDocumentUsecase(
          ShareDocumentRepository(
            ShareDocumentDatasource(
              shareService: ShareService(),
            ),
          ),
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NfPage(),
      ),
    );
  }
}
