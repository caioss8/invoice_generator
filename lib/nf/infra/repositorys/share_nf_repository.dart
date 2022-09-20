import 'package:fpdart/fpdart.dart';

import '../../../core/params/params.dart';
import '../../domain/repositorys/i_share_nf_repository.dart';
import '../datasources/i_share_nf_datasource.dart';

class ShareDocumentRepository implements IShareDocumentRepository {
  final IShareDocumentDatasource _datasource;

  const ShareDocumentRepository(this._datasource);

  @override
  Future<Either<Exception, Unit>> call(ShareDocumentParam param) async {
    try {
      final response = await _datasource(param);
      return Right(response);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
