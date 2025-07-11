

import 'package:blog_app/core/error/ServerException.dart';
import 'package:blog_app/feacher/authentication/data/Models/User_Model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource{
  Session? get currentsession;
  Future<UserModel> sigUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password
});
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password
  });
  Future<UserModel?>  getcurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentsession => supabaseClient.auth.currentSession;


  @override
  Future<UserModel> loginWithEmailAndPassword({required String email, required String password}) async{
    try{
      final responce = await  supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,
      );
      if(responce.user==null){
        throw ServerExeception("User is null");
      }
      return UserModel.fromJson(responce.user!.toJson());

    }catch(e){
      throw ServerExeception(e.toString());
    }
  }

  @override
  Future<UserModel> sigUpWithEmailAndPassword({required String name, required String email, required String password}) async{
    try{
      final responce = await  supabaseClient.auth.signUp(
          password: password,
          email: email,
        data: {
            "name":name,
        }
      );
      return UserModel.fromJson(responce.user!.toJson());

    }catch(e){
      throw ServerExeception(e.toString());
    }
  }

  @override
  Future<UserModel?> getcurrentUser() async{
    try{
      if(currentsession!=null){
        final userdata = await supabaseClient.from('profiles').select().eq('id', currentsession!.user.id);
        return UserModel.fromJson(userdata.first);
      }
    }catch(e){
      throw ServerExeception(e.toString());
    }
  }
}