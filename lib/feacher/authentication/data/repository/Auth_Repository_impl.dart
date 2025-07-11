import 'package:blog_app/core/error/Failures.dart';
import 'package:blog_app/core/error/ServerException.dart';
import 'package:blog_app/core/network/Connection_checker.dart';
import 'package:blog_app/feacher/authentication/data/Models/User_Model.dart';
import 'package:blog_app/feacher/authentication/data/dataSources/Auth_Remote_Data_Source.dart';
import 'package:blog_app/feacher/authentication/domain/repository/AuthRepository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/Entities/User.dart';
class AuthRepositoryImpl implements AuthRepository{
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource , this.connectionChecker);
  @override
  Future<Either<Failures, User>> loginWithEmailPassword(
      {required String email, required String password}
      ) async{
    try{
      if(!await (connectionChecker.isConnected)){
        return left(Failures('No Internet connection'));
      }
      final userid = await authRemoteDataSource.loginWithEmailAndPassword( email: email, password: password);
      return right(userid);
    } on ServerExeception catch(e){
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  }) async{
    try{
      if(!await (connectionChecker.isConnected)){
        return left(Failures('No Internet connection'));
      }
      final userid = await authRemoteDataSource.sigUpWithEmailAndPassword(name: name, email: email, password: password);
      return right(userid);
    } on ServerExeception catch(e){
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> currentUser() async{
    try{
      if(!await (connectionChecker.isConnected)){
        final session = authRemoteDataSource.currentsession;
        if(session == null){
          return left(Failures('User is not log in'));
        }
        return right(UserModel(id: session.user.id, email: session.user.email??'', password:'' ));
      }
      final user= await authRemoteDataSource.getcurrentUser();
      if(user!=null){
        return right(user);
      }
      return left(Failures('User is not login'));
    }on ServerExeception catch(e){
      return left(Failures(e.message));
    }
  }
}