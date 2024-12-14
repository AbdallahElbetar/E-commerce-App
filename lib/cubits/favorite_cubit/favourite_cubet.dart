import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/models/in_fav_product_model.dart';

import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(InitialState());
  final Dio dio = Dio();
  List<InFavProductModel> favouriteProducts = [];
  Set<int> favProductId = {};

  Future<List<InFavProductModel>> getFavProducts() async {
    favouriteProducts.clear();
    favProductId.clear();
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

      final List<dynamic> jsonData = response.data["data"]["data"];

      for (var element in jsonData) {
        favouriteProducts.add(InFavProductModel.fromJson(
            jsonData: element["product"] as Map<String, dynamic>));
        favProductId.add(
          element["product"]["id"],
        );
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
      log(SharedPrefrencesService.getFromCache(key: "token"));

      return Future.error(e.toString());
    }
  }

  Future<void> deleteOrAddProductToFavourite({required num id}) async {
    try {
      emit(LoadingDeleteOrAddToFavouriteState());
      Response response = await dio.post(
        deleteOrAddFavProductsBaseUrl,
        data: {
          "product_id": id,
        },
        options: Options(
          headers: {
            "lang": "en",
            "Content-Type": "application/json",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          },
        ),
      );
      Map<String, dynamic> jsonData = response.data;
      if (jsonData["status"] == true) {
        if (jsonData["message"] == "Added Successfully" ||
            favProductId.contains(id)) {
          favProductId.remove(id);
        } else {
          favProductId.add(id as int);
        }

        await getFavProducts();

        emit(SuccessDeleteOrAddToFavouriteState());
      } else {
        emit(FailureDeleteOrAddToFavouriteState(message: jsonData["message"]));
      }
    } on DioException catch (e) {
      emit(FailureDeleteOrAddToFavouriteState(message: e.message!));
      log("Dio Error: ${e.message}");
      return Future.error(e.message!);
    } catch (e) {
      emit(FailureDeleteOrAddToFavouriteState(message: e.toString()));
      log("General Error: ${e.toString()}");
      return Future.error(e.toString());
    }
  }
}
