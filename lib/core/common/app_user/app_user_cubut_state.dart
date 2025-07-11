import 'package:blog_app/core/common/Entities/User.dart';

sealed class AppUserCubitState{}


final class AppUserInit extends AppUserCubitState{}
final class AppUserLoggedIn extends AppUserCubitState{
  final User user;
  AppUserLoggedIn( this.user);
}


