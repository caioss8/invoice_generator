import 'package:fpdart/fpdart.dart';

import '../../../../core/params/params.dart';
import '../../repositorys/i_share_nf_repository.dart';
import 'i_share_nf_usecase.dart';

class ShareDocumentUsecase implements IShareDocumentUsecase {
  final IShareDocumentRepository _repository;

  const ShareDocumentUsecase(this._repository);

  @override
  Future<Either<Exception, Unit>> call(ShareDocumentParam param) async {
    if (param.filesPath.isEmpty) {
      return Left(
        Exception(),
      );
    }

    return await _repository(param);
  }
}
