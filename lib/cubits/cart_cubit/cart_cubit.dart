import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(IntialState());
  Dio dio = Dio();
  List<ProductModel> cartProductList = [];

  Future<List<ProductModel>> getCartProducts() async {
    try {
      emit(LoadingGetDataCart());
      cartProductList.clear();
      Response response = await dio.get(getCartProductBaseUrl,
          options: Options(headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          }));
      List<dynamic> jsonData = response.data["data"]["cart_items"];
      for (var item in jsonData) {
        cartProductList.add(
          ProductModel.fromJson(
            jsonData: item["product"],
          ),
        );
      }
      log("Success Fetced Cart Data $cartProductList");
      emit(SuccessGetDataCart());
      return cartProductList;
    } on DioException catch (e) {
      log("Dio Error${e.message} ");
      emit(FailureGetDataCart(message: e.message!));
      return Future.error(e.message!);
    } catch (e) {
      log("General Error${e.toString()} ");
      emit(FailureGetDataCart(message: e.toString()));
      return Future.error(e.toString());
    }
  }
}
