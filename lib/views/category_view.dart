import 'package:ecommerce/api/home_page_services.dart';
import 'package:ecommerce/models/categories_model.dart';
import 'package:ecommerce/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: FutureBuilder<List<CategoriesModel>>(
          future: HomePageServices().getCategoriesData(),
          builder: (BuildContext contetx, AsyncSnapshot snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else if (snapShot.hasError) {
              return Center(
                  child: Text("Error fetching Categories : ${snapShot.error}"));
            } else if (snapShot.hasData) {
              List<CategoriesModel> CategoriesData = snapShot.data!;
              return Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: CategoriesData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: .8,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryCard(
                            categoriesModel: CategoriesData[index]);
                      }));
            } else {
              return Center(child: Text("No banners available"));
            }
          }),
    );
  }
}
