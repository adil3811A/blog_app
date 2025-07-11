

 import 'package:blog_app/core/error/Failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/Entities/User.dart';

abstract interface class AuthRepository{
   Future<Either<Failures, User>> singUpWithEmailPassword({
     required String name,
     required String email,
     required String password
});
   Future<Either<Failures, User>> loginWithEmailPassword({
     required String email,
     required String password
   });
   Future<Either<Failures , User>> currentUser();
}