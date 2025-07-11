
import 'package:blog_app/core/error/Failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccesType,perm>{
  Future<Either<Failures ,SuccesType>> call(perm perm);
}
class NoPeram{

}