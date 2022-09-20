import 'package:fpdart/fpdart.dart';
import '../../../../core/params/params.dart';

abstract class IShareDocumentUsecase {
  Future<Either<Exception, Unit>> call(ShareDocumentParam param);
}
