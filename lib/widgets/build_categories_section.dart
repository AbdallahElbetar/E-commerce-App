import 'package:ecommerce/api/home_page_services.dart';
import 'package:ecommerce/models/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildCategoriesSection extends StatelessWidget {
  const BuildCategoriesSection(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoriesModel>>(
      future: HomePageServices().getCategoriesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error fetching categories"));
        } else if (snapshot.hasData) {
          List<CategoriesModel> categoriesData = snapshot.data!;
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categoriesData.length,
              itemBuilder: (context, index) {
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(categoriesData[index].image),
                );
              },
            ),
          );
        } else {
          return Center(child: Text("No categories available"));
        }
      },
    );
    ;
  }
}
