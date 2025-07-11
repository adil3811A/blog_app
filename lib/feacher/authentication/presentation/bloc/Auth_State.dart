

import '../../../../core/common/Entities/User.dart';

sealed class AuthState{}


final  class AuthIntiState extends AuthState{}
final class AuthLoading extends AuthState{}
final class AuthSuccess extends AuthState{
  final User user;

  AuthSuccess(this.user);
}
final class AuthFailure extends AuthState{
  final String message;

  AuthFailure({required this.message});
}



