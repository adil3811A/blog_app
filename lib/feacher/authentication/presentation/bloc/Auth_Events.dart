


sealed class AuthEvent{}

class AuthSingUp  extends AuthEvent{
  final String name;
  final String email;
  final String password;
  AuthSingUp(this.name, this.email, this.password);
}
final class AuthIsUserLogin extends AuthEvent{}
class AuthLogin extends AuthEvent{
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

}