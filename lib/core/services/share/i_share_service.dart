import 'package:fpdart/fpdart.dart';

import 'helpers/params.dart';

abstract class IShareService {
  Future<Unit> shareFiles(ShareFilesParam param);
}
