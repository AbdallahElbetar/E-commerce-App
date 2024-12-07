import 'package:ecommerce/models/product_model.dart';

import 'package:flutter/material.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.height * 0.250,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.height * 0.250,
              productModel.image,
              fit: BoxFit.contain,
            ),
            Text(
              productModel.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productModel.price}\$",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "${productModel.discount}\$",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: .5,
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Remove",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
