abstract class CartStates {}

class IntialState extends CartStates {}

class SuccessGetDataCart extends CartStates {}

class LoadingGetDataCart extends CartStates {}

class FailureGetDataCart extends CartStates {
  final String message;
  FailureGetDataCart({required this.message});
}
