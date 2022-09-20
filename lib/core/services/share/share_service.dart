import 'package:fpdart/fpdart.dart';

import 'package:share_plus/share_plus.dart';
import 'helpers/params.dart';
import 'i_share_service.dart';

class ShareService implements IShareService {
  const ShareService();

  @override
  Future<Unit> shareFiles(ShareFilesParam param) async {
    await Share.shareFiles(
      param.filesPath.toList(),
      text: param.message,
    );

    return unit;
  }
}
