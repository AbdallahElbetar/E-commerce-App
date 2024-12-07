import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/widgets/favourite_card.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FavouriteCubit>(context);

    cubit.getFavProducts();
    return Scaffold(
        body: BlocConsumer<FavouriteCubit, FavouriteStates>(
      listener: (BuildContext context, FavouriteStates state) {},
      builder: (BuildContext context, FavouriteStates state) {
        if (state is SuccessAddToFavouriteState) {
          return GridView.builder(
            itemCount: cubit.favouriteProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                // mainAxisSpacing: 8,
                // crossAxisSpacing: 8,
                childAspectRatio: 1.5),
            itemBuilder: (context, index) {
              return FavouriteCard(
                  productModel: cubit.favouriteProducts[index]);
            },
          );
        } else if (state is LoadingAddToFavouriteState) {
          return Center(
            child: CupertinoActivityIndicator(
              color: Colors.black,
            ),
          );
        } else {
          return Center(
            child: Text(
              "There are no favorite products",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    ));
  }
}
