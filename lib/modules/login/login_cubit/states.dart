
abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginsSuccessState extends LoginStates
{
  final String uId;

  LoginsSuccessState(this.uId);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);

}
class SocialPasswordState extends LoginStates{}