import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/banner_model.dart';

import 'package:ecommerce/models/categories_model.dart';

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

  Future<List<BannerModel>> getBannerData() async {
    try {
      final List<BannerModel> bannerDataList = [];

      final Response response = await Dio().get(getBannersDataUrl);

      final List<dynamic> jsonData = response.data["data"];
      for (int i = 0; i < jsonData.length; i++) {
        bannerDataList.add(BannerModel.fromJson(json: jsonData[i]));
      }
      log('Success Get Data $bannerDataList');

      return bannerDataList;
    } on DioException catch (e) {
      log('Dio error: ${e.message}');

      return Future.error('Failed to load banner data');
    } catch (e) {
      log('General Error: $e');

      return Future.error('Unexpected error occurred');
    }
  }
}
