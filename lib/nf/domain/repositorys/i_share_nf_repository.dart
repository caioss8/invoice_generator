import 'package:fpdart/fpdart.dart';
import '../../../core/params/params.dart';

abstract class IShareDocumentRepository {
  Future<Either<Exception, Unit>> call(ShareDocumentParam param);
}
