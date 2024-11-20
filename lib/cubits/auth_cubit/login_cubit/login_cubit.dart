import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/auth_cubit/login_cubit/login_states.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginLIntialState());
  Dio dio = Dio();

  Future<dynamic> loginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      Response response = await dio.post(
        loginUserBaseUrl,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {"Content-Type": "application/json", "lang": "ar"},
        ),
      );

      if (response.data["status"] == true) {
        SharedPrefrencesService.setToCache(
            key: "token", value: response.data["data"]["token"]);
        emit(LoginSuccessState());
      } else {
        emit(
          LoginFailureState(
            message: response.data["message"],
          ),
        );
      }
    } on DioException catch (e) {
      log("${e.message}");

      emit(
        LoginFailureState(
            // message: "An error occurred. Please try again later.",
            message: "${e.message}"),
      );
    } catch (e) {
      log("${e.toString()}");
      emit(
        LoginFailureState(
          message: "An error occurred. Please try again later.",
        ),
      );
    }
  }
}
