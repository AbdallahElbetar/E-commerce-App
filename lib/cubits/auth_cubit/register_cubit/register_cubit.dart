import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/auth_cubit/register_cubit/register_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterIntialState());

  Dio dio = Dio();
  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      // emit loading
      emit(RegisterLoadingState());

      Response response = await dio.post(registerBaseUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "lang": "en",
          }),
          data: {
            "name": name,
            "email": email,
            "password": password,
            "phone": phone,
          });

      if (response.data["status"] == true) {
        emit(RegisterSuccessState());
      } else {
        emit(
          RegisterFaluireState(message: response.data["message"]),
        );
      }
    } on DioException catch (e) {
      emit(RegisterFaluireState(message: e.message!));
    } catch (e) {
      emit(RegisterFaluireState(message: "Failed State${e.toString()} "));
    }
  }
}
