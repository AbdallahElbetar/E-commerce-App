import 'package:ecommerce/models/categories_model.dart';

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({required this.categoriesModel});
  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                categoriesModel.image,
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.height * 0.250,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              categoriesModel.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
