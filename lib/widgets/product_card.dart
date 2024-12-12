// import 'package:ecommerce/cubits/cart_cubit/cart_cubit.dart';
// import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';
// import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
// import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
// import 'package:ecommerce/models/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductCard extends StatelessWidget {
//   final ProductModel productModel;

//   ProductCard({required this.productModel});

//   @override
//   Widget build(BuildContext context) {
//     var favCubit = BlocProvider.of<FavouriteCubit>(context);
//     var cartCubit = BlocProvider.of<CartCubit>(context);
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.25,
//       width: MediaQuery.of(context).size.height * 0.250,
//       decoration: BoxDecoration(
//           color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.network(
//             height: MediaQuery.of(context).size.height * 0.20,
//             width: MediaQuery.of(context).size.height * 0.250,
//             productModel.image,
//             fit: BoxFit.contain,
//           ),
//           Text(
//             productModel.name,
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${productModel.price}\$",
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//               BlocBuilder<FavouriteCubit, FavouriteStates>(
//                 builder: (context, state) {
//                   return IconButton(
//                       onPressed: () {
//                         favCubit.deleteOrAddProductToFavourite(
//                             id: productModel.id);
//                       },
//                       icon: Icon(
//                         Icons.favorite,
//                         color: favCubit.favProductId.contains(productModel.id)
//                             ? Colors.red
//                             : Colors.grey,
//                       ));
//                 },
//               )
//             ],
//           ),
//           BlocBuilder<CartCubit, CartStates>(
//             bloc: cartCubit,
//             builder: (context, state) {
//               return Flexible(
//                   child: GestureDetector(
//                 onTap: () {
//                   cartCubit.addOrRemoveFromCart(productID: productModel.id);
//                 },
//                 child: Icon(Icons.add_shopping_cart,
//                     color: (cartCubit.cartProductId.contains(productModel.id)
//                         ? Colors.green
//                         : Colors.black)),
//               ));
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:ecommerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  ProductCard({required this.productModel});

  @override
  Widget build(BuildContext context) {
    var favCubit = BlocProvider.of<FavouriteCubit>(context);
    var cartCubit = BlocProvider.of<CartCubit>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
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
              BlocBuilder<FavouriteCubit, FavouriteStates>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        favCubit.deleteOrAddProductToFavourite(
                            id: productModel.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: favCubit.favProductId.contains(productModel.id)
                            ? Colors.red
                            : Colors.grey,
                      ));
                },
              )
            ],
          ),
          BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {
              if (state is SuccessAddOrRemoveFromCart) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        cartCubit.cartProductId.contains(productModel.id)
                            ? 'Added to cart'
                            : 'Removed from cart'),
                    duration: Duration(seconds: 0),
                  ),
                );
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  cartCubit.addOrRemoveFromCart(productID: productModel.id);
                },
                child: Icon(
                  Icons.add_shopping_cart,
                  color: cartCubit.cartProductId.contains(productModel.id)
                      ? Colors.green
                      : Colors.black,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
