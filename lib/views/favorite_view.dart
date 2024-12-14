import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/widgets/favourite_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FavouriteCubit>(context);

    // Fetch favorite products on build
    cubit.getFavProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
        centerTitle: true,
      ),
      body: BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (BuildContext context, FavouriteStates state) {
          if (state is FailureDeleteOrAddToFavouriteState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to update favorite status"),
              ),
            );
          }
        },
        builder: (BuildContext context, FavouriteStates state) {
          if (state is LoadingAddToFavouriteState) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Colors.black,
                radius: MediaQuery.of(context).size.height * 0.04,
              ),
            );
          } else if (cubit.favouriteProducts.isEmpty) {
            return Center(
              child: Text(
                "There are no favorite products",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await cubit.getFavProducts(); // Refresh the favorites
              },
              child: GridView.builder(
                itemCount: cubit.favouriteProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                ),
                itemBuilder: (context, index) {
                  return FavouriteCard(
                    favProductModel: cubit.favouriteProducts[index],
                    onPressed: () {
                      // Handle the favorite button press
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
