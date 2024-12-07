import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(InitialState());
  final Dio dio = Dio();
  List<ProductModel> favouriteProducts = [];

  Future<List<ProductModel>> getFavProducts() async {
    try {
      emit(LoadingAddToFavouriteState());

      final response = await dio.get(
        getFavProductsBaseUrl,
        options: Options(
          headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          },
        ),
      );

      log(SharedPrefrencesService.getFromCache(key: "token"));
      favouriteProducts.clear();
      final List<dynamic> jsonData = response.data["data"]["data"];

      for (var element in jsonData) {
        favouriteProducts.add(ProductModel.fromJson(
            jsonData: element["product"] as Map<String, dynamic>));
      }

      log("Success: Fetched ${favouriteProducts.length} favorite products.");
      emit(SuccessAddToFavouriteState());
      return favouriteProducts;
    } on DioException catch (e) {
      emit(FailureAddToFavouriteState(message: e.message!));
      log("Dio Error: ${e.message}");
      return Future.error(e.message!);
    } catch (e) {
      emit(FailureAddToFavouriteState(message: e.toString()));
      log("General Error: ${e.toString()}");
      return Future.error(e.toString());
    }
  }
}
