
import 'package:blog_app/core/userCase/useCase.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/Current_User.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/User_Login.dart';
import 'package:blog_app/feacher/authentication/domain/useCases/User_Sing_Up.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_Events.dart';
import 'package:blog_app/feacher/authentication/presentation/bloc/Auth_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/Entities/User.dart';
import '../../../../core/common/app_user/app_User_cubit.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final UserSingUp _userSingUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSingUp userSingUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }):_userSingUp = userSingUp ,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthIntiState()){
    on<AuthEvent>((_, emit) => emit(AuthLoading()),);
    on<AuthSingUp>(_onAuthSingUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLogin>(_isUserLogin);
  }

  void _isUserLogin(
      AuthIsUserLogin event ,
      Emitter<AuthState> emit
      ) async{
    final res =await _currentUser.call(NoPeram());
    res.fold((l) => emit(AuthFailure(message: l.message)), (r)=>_emitAuthSuccess(r, emit));
    }

  void _onAuthLogin(AuthLogin event , Emitter<AuthState> emit) async{
    final respons = await _userLogin.call(UserLoginParm(event.email, event.password));
    respons.fold((l) => emit(AuthFailure(message: l.message)), (r) => _emitAuthSuccess(r, emit),);
  }

  void _onAuthSingUp(AuthSingUp event, Emitter<AuthState> emit)async{
    final responce = await _userSingUp.call(UserSingUpPerm(event.name, event.email, event.password));
    responce.fold((l) {
      emit(AuthFailure(message: l.message));
    }, (user) {
      _emitAuthSuccess(user, emit);
    },);
  }
  void _emitAuthSuccess(
      User user,
      Emitter<AuthState> emit,
      ){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}