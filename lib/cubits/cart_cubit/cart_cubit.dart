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
  Set<int> cartProductId = {};

  Future<List<ProductModel>> getCartProducts() async {
    try {
      emit(LoadingGetDataCart());
      cartProductList.clear();
      cartProductId.clear();
      Response response = await dio.get(getCartProductBaseUrl,
          options: Options(headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          }));
      List<dynamic> jsonData = response.data["data"]["cart_items"];
      for (var item in jsonData) {
        var product = ProductModel.fromJson(jsonData: item["product"]);
        cartProductList.add(product);
        // cartProductId.add(product.id);
      }
      log("Success Fetched Cart Data $cartProductList");
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

  Future<void> addOrRemoveFromCart({required int productID}) async {
    try {
      emit(LoadingGetDataCart());
      Response response = await dio.post(addOrRemoveFromCartProductBaseUrl,
          options: Options(headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          }),
          data: {
            "product_id": productID,
          });

      Map<String, dynamic> jsonData = response.data;

      if (jsonData["status"] == true) {
        if (cartProductId.contains(productID)) {
          cartProductId.remove(productID);
        } else {
          cartProductId.add(productID);
        }
        await getCartProducts();
        emit(SuccessAddOrRemoveFromCart());
      } else {
        emit(FailureAddOrRemoveFromCart(message: jsonData["message"]));
      }
    } on DioException catch (e) {
      log("Dio Error ${e.message}");
      emit(FailureAddOrRemoveFromCart(message: e.message!));
    } catch (e) {
      log("General Error ${e.toString()}");
      emit(ErrorAddOrRemoveFromCart(error: e.toString()));
    }
  }
}
