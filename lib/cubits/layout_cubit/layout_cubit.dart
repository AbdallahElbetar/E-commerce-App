import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:ecommerce/views/category_view.dart';
import 'package:ecommerce/views/favorite_view.dart';
import 'package:ecommerce/views/home_view.dart';
import 'package:ecommerce/views/profile_view.dart';
import 'package:ecommerce/views/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(IntialUserDataState());

  int indexBottomNavBar = 0;
  void bottomNavChanged({required int value}) {
    indexBottomNavBar = value;
    emit(BottomNavigationChangedState());
  }

  List<Widget> layoutListView = <Widget>[
    HomeView(),
    CategoryView(),
    ShoppingCart(),
    FavoriteView(),
    ProfilePage(),
  ];

  Dio dio = Dio();
  UserModel? userModel; // Nullable user model

  Future<void> getUserData() async {
    // Check if token exists
    String? token = SharedPrefrencesService.getFromCache(key: "token");
    if (token == null) {
      emit(FailureUserDataState(message: "Token not found"));
      return; // Exit early if token is not available
    }

    try {
      emit(LoadingUserDataState());
      Response response = await dio.get(
        getUserDataBaseUrl,
        options: Options(
          headers: {
            "lang": "en",
            "Authorization": token,
            "Content-Type": "application/json"
          },
        ),
      );

      log("API Response: ${response.data}");

      if (response.data["status"] == true) {
        userModel = UserModel.fromJson(jsonData: response.data);
        emit(SuccessUserDataState(userModel: userModel!));
      } else {
        emit(FailureUserDataState(message: response.data["message"]));
        log(token);

        log("API Error: ${response.data["message"]}");
      }
    } on DioException catch (e) {
      log("Dio Exception: ${e.message}");
      emit(FailureUserDataState(message: e.message ?? "Dio error"));
    } catch (e) {
      log("General Exception: ${e.toString()}");
      emit(FailureUserDataState(message: e.toString()));
    }
  }
}
