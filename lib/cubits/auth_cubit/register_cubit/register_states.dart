class RegisterStates {}

class RegisterIntialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFaluireState extends RegisterStates {
  final String message;
  RegisterFaluireState({
    required this.message,
  });
}
