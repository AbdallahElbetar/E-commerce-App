import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';

import 'package:ecommerce/models/product_model.dart';
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
  List<ProductModel> productDataListWillFiltter = [];
  int indexBottomNavBar = 0;
  void bottomNavChanged({required int value}) {
    indexBottomNavBar = value;
    emit(BottomNavigationChangedState());
  }

  List<Widget> layoutListView = <Widget>[
    HomeView(),
    CategoryView(),
    FavoriteView(),
    ShoppingCart(),
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

  Future<List<ProductModel>> getHomeProduct() async {
    try {
      emit(LoadingGetProductState());
      List<ProductModel> productDataList = [];
      Response response = await dio.get(
        getProductsHomeBaseUrl,
        options: Options(
          headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          },
        ),
      );

      List<dynamic> jsonData = response.data["data"]["products"];
      for (int i = 0; i < jsonData.length; i++) {
        productDataList.add(ProductModel.fromJson(jsonData: jsonData[i]));
      }

      log('Success Get Data $productDataList');
      productDataListWillFiltter = productDataList;
      emit(SuccessGetProductState(productData: productDataList));
      return productDataList;
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      emit(FailureGetProductState(message: e.message!));

      return Future.error('Failed to load categories data: ${e.message}');
    } catch (e) {
      log('General error: $e');
      emit(FailureGetProductState(message: e.toString()));
      return Future.error(e.toString());
    }
  }

  List<ProductModel> productFilttered = [];
  List<ProductModel> fliterProductData({required String input}) {
    productFilttered.clear(); // Clear previous filtered results

    if (input.isNotEmpty && productDataListWillFiltter.isNotEmpty) {
      productFilttered = productDataListWillFiltter
          .where((product) =>
              product.name.toLowerCase().startsWith(input.toLowerCase()))
          .toList();
    }

    emit(SuccessFiltterData(productData: productFilttered));
    return productFilttered;
  }

  Future<void> changePasswordUser(
      {required String currentPassword, required String newPassword}) async {
    try {
      emit(LoadingChangePasswordUserState());
      Response response = await dio.post(changePasswordUserBaseUrl,
          options: Options(
            headers: {
              "lang": "en",
              "Content-Type": "application/json",
              "Authorization":
                  SharedPrefrencesService.getFromCache(key: "token"),
            },
          ),
          data: {
            "current_password": currentPassword,
            "new_password": newPassword,
          });
      if (response.data["status"] == true) {
        log("Succes Change Password");
        emit(SuccessChangePasswordUserState(message: response.data["message"]));
      } else {
        log("Failure Change Password");
        emit(FailureChangePasswordUserState(error: response.data["message"]));
      }
    } on DioException catch (e) {
      log("IN Dio Error ${e.message.toString()}");
      emit(FailureChangePasswordUserState(error: e.message.toString()));
    } catch (e) {
      log("In General Error ${e.toString()}");
      emit(FailureChangePasswordUserState(error: e.toString()));
    }
  }

  Future<void> logOutUser({required String fcmToken}) async {
    try {
      emit(LoadingLogOutUserState());
      Response response = await dio.post(logOutUserBaseUrl,
          options: Options(
            headers: {
              "lang": "en",
              "Content-Type": "application/json",
              "Authorization":
                  SharedPrefrencesService.getFromCache(key: "token"),
            },
          ),
          data: {
            "fcm_token": fcmToken,
          });
      Map<String, dynamic> jsonData = response.data;

      if (jsonData["status"] == true) {
        log("Success LogOut  Token is ${SharedPrefrencesService.getFromCache(key: "token")}");

        emit(
          SuccessLogOutUserState(
            message: jsonData["message"],
          ),
        );
        await SharedPrefrencesService.deletefromCache(key: "token");
      } else {
        log("Failed LogOut Token is ${SharedPrefrencesService.getFromCache(key: "token")}");

        emit(FailureLogOutUserState(error: jsonData["message"]));
      }
    } on DioException catch (e) {
      log("In Dio Error ${e.message}");
      emit(FailureLogOutUserState(error: e.message!.toString()));
    } catch (e) {
      log("In General Error ${e.toString()}");
      emit(FailureLogOutUserState(error: e.toString()));
    }
  }
}
