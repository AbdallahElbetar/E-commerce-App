abstract class CartStates {}

class IntialState extends CartStates {}

class SuccessGetDataCart extends CartStates {}

class LoadingGetDataCart extends CartStates {}

class FailureGetDataCart extends CartStates {
  final String message;
  FailureGetDataCart({required this.message});
}

class SuccessAddOrRemoveFromCart extends CartStates {}

class FailureAddOrRemoveFromCart extends CartStates {
  final String message;
  FailureAddOrRemoveFromCart({required this.message});
}

class ErrorAddOrRemoveFromCart extends CartStates {
  final String error;

  ErrorAddOrRemoveFromCart({required this.error});
}
