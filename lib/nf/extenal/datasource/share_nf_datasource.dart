import 'package:fpdart/fpdart.dart';

import '../../../core/params/params.dart';
import '../../../core/services/share/helpers/params.dart';
import '../../../core/services/share/i_share_service.dart';
import '../../infra/datasources/i_share_nf_datasource.dart';

class ShareDocumentDatasource implements IShareDocumentDatasource {
  final IShareService _shareService;

  const ShareDocumentDatasource({
    required IShareService shareService,
  }) : _shareService = shareService;

  @override
  Future<Unit> call(ShareDocumentParam param) async {
    final shareParam = ShareFilesParam(
      filesPath: param.filesPath,
      message: param.message,
    );
    await _shareService.shareFiles(shareParam);

    return unit;
  }
}
