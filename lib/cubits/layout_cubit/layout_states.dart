import 'package:ecommerce/models/banner_model.dart';
import 'package:ecommerce/models/categories_model.dart';
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

class LoadingGetBannerState extends LayoutStates {}

class SuccessGetBannerState extends LayoutStates {
  List<BannerModel> bannerData;
  SuccessGetBannerState({required this.bannerData});
}

class FailureGetBannerState extends LayoutStates {
  final String message;
  FailureGetBannerState({required this.message});
}
