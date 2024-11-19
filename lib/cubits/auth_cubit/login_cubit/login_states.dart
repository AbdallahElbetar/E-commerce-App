abstract class LoginStates {}

class LoginLIntialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailureState extends LoginStates {
  final String message;
  LoginFailureState({required this.message});
}
