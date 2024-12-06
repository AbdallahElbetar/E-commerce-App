import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  ProductCard({required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.height * 0.250,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
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
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
