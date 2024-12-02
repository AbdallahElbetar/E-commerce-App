import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants.dart';

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
}
