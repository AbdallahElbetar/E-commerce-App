import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/models/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final favCubit = BlocProvider.of<FavouriteCubit>(context);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child:
          // Product details
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    productModel.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${productModel.price}\$',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            '${productModel.oldPrice}\$',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: .5,
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FavouriteCubit, FavouriteStates>(
                  bloc: favCubit,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        favCubit.deleteOrAddProductToFavourite(
                            id: productModel.id);
                      },
                      icon: (favCubit.favProductId.contains(productModel.id)
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              size: 30,
                            )),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 30,
                    ))
              ],
            )
          ],
        ),
      ),
      // Remove button
    );
  }
}
