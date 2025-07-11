import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/authentication/domain/repository/AuthRepository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/Entities/User.dart';



class UserLogin implements UseCase<User , UserLoginParm>{
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserLoginParm perm) async{
    return await authRepository.loginWithEmailPassword(
        email: perm.email, password: perm.password
    );
  }

}

class UserLoginParm{
  final String email;
  final String password;

  UserLoginParm(this.email, this.password);
}