

import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/authentication/domain/repository/AuthRepository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/Entities/User.dart' show User;


class CurrentUser  implements UseCase<User,NoPeram >{

  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failures, User>> call(NoPeram perm) async{
    return await authRepository.currentUser();
  }

}

