import 'package:fpdart/fpdart.dart';

import '../../../core/params/params.dart';

abstract class IShareDocumentDatasource {
  Future<Unit> call(ShareDocumentParam param);
}
