
import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/authentication/domain/repository/AuthRepository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/Entities/User.dart';

class UserSingUp implements UseCase<User,UserSingUpPerm> {
  final AuthRepository authRepository;

  UserSingUp(this.authRepository);

  @override
  Future<Either<Failures, User>> call(UserSingUpPerm perm) async{
    return  authRepository.singUpWithEmailPassword(name: perm.name, email: perm.email, password: perm.password);
  }
}

class UserSingUpPerm{
  final String name;
  final String email;
  final String password;
  UserSingUpPerm(this.name, this.email, this.password);


}