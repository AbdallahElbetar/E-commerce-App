import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';

import 'package:ecommerce/models/categories_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';

class HomePageServices {
  Dio dio = Dio();

  Future<List<CategoriesModel>> getCategoriesData() async {
    try {
      List<CategoriesModel> categoriesDataList = [];
      Response response = await dio.get(
        getCategoriesBaseUrl,
        options: Options(
          headers: {
            "lang": "ar",
          },
        ),
      );

      List<dynamic> jsonData = response.data["data"]["data"];
      for (int i = 0; i < jsonData.length; i++) {
        categoriesDataList.add(
          CategoriesModel.fromJson(jsonData: jsonData[i]),
        );
      }

      log('Success Get Data $categoriesDataList');
      return categoriesDataList;
    } on DioException catch (e) {
      log('Dio error: ${e.message}');

      return Future.error('Failed to load categories data: ${e.message}');
    } catch (e) {
      log('General error: $e');

      return Future.error(e.toString());
    }
  }

  Future<List<ProductModel>> getHomeProduct() async {
    try {
      List<ProductModel> productDataList = [];
      Response response = await dio.get(
        getProductsHomeBaseUrl,
        options: Options(
          headers: {
            "lang": "ar",
            "Authorization": SharedPrefrencesService.getFromCache(key: "token"),
          },
        ),
      );

      List<dynamic> jsonData = response.data["data"]["products"];
      for (int i = 0; i < jsonData.length; i++) {
        productDataList.add(ProductModel.fromJson(jsonData: jsonData[i]));
      }

      log('Success Get Data $productDataList');
      return productDataList;
    } on DioException catch (e) {
      log('Dio error: ${e.message}');

      return Future.error('Failed to load categories data: ${e.message}');
    } catch (e) {
      log('General error: $e');

      return Future.error(e.toString());
    }
  }
}
