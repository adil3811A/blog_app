

import 'package:blog_app/core/common/app_user/app_user_cubut_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/common/Entities/User.dart';

class AppUserCubit extends Cubit<AppUserCubitState>{
  AppUserCubit() : super(AppUserInit());


  void updateUser(User? user){
    if(user!=null){
      emit(AppUserLoggedIn(user));
    }else{
      emit(AppUserInit());
    }
  }
}