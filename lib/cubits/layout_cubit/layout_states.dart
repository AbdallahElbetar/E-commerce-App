import 'package:ecommerce/models/product_model.dart';

import 'package:ecommerce/models/user_model.dart';

abstract class LayoutStates {}

class IntialUserDataState extends LayoutStates {}

class SuccessUserDataState extends LayoutStates {
  final UserModel userModel;
  SuccessUserDataState({
    required this.userModel,
  });
}

class LoadingUserDataState extends LayoutStates {}

class FailureUserDataState extends LayoutStates {
  final String message;
  FailureUserDataState({required this.message});
}

class BottomNavigationChangedState extends LayoutStates {}

class LoadingGetProductState extends LayoutStates {}

class SuccessGetProductState extends LayoutStates {
  List<ProductModel> productData;
  SuccessGetProductState({required this.productData});
}

class FailureGetProductState extends LayoutStates {
  final String message;
  FailureGetProductState({required this.message});
}

class SuccessFiltterData extends LayoutStates {
  List<ProductModel> productData;
  SuccessFiltterData({required this.productData});
}

class SuccessChangePasswordUserState extends LayoutStates {
  final String message;
  SuccessChangePasswordUserState({required this.message});
}

class LoadingChangePasswordUserState extends LayoutStates {}

class FailureChangePasswordUserState extends LayoutStates {
  final String error;
  FailureChangePasswordUserState({required this.error});
}

class SuccessLogOutUserState extends LayoutStates {
  final String message;
  SuccessLogOutUserState({required this.message});
}

class LoadingLogOutUserState extends LayoutStates {}

class FailureLogOutUserState extends LayoutStates {
  final String error;
  FailureLogOutUserState({required this.error});
}
