import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/models/product_model.dart';

import 'package:ecommerce/cubits/favorite_cubit/favourite_states.dart';
import 'package:ecommerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildProductImage(context),
          _buildProductName(),
          _buildPriceAndFavorite(context),
          _buildAddToCartButton(context),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Image.network(
      product.image,
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.height * 0.25,
      fit: BoxFit.contain,
    );
  }

  Widget _buildProductName() {
    return Text(
      product.name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPriceAndFavorite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${product.price}",
          style: const TextStyle(color: Colors.grey),
        ),
        _buildFavoriteButton(context),
      ],
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteStates>(
      builder: (context, state) {
        final favCubit = context.read<FavouriteCubit>();
        final isInFav = product.inFavorites;

        return IconButton(
          onPressed: () =>
              favCubit.deleteOrAddProductToFavourite(id: product.id),
          icon: Icon(
            Icons.favorite,
            color: isInFav ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is SuccessAddOrRemoveFromCart) {
          _showSnackBar(context);
        }
      },
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final isInCart = cartCubit.cartProductId.contains(product.id);

        return GestureDetector(
          onTap: () => cartCubit.addOrRemoveFromCart(productID: product.id),
          child: Icon(
            Icons.add_shopping_cart,
            color: isInCart ? Colors.green : Colors.black,
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final isInCart = cartCubit.cartProductId.contains(product.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isInCart ? 'Added to cart' : 'Removed from cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
