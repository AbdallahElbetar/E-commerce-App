// import 'package:ecommerce/cubits/cart_cubit/cart_cubit.dart';
// import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';
// import 'package:ecommerce/widgets/cart_card.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ShoppingCart extends StatelessWidget {
//   const ShoppingCart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var cubit = BlocProvider.of<CartCubit>(context);
//     cubit.getCartProducts();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Cart Products",
//         ),
//         centerTitle: true,
//       ),
//       body: BlocConsumer<CartCubit, CartStates>(
//         listener: (BuildContext context, state) {},
//         builder: (BuildContext context, state) {
//           if (state is LoadingGetDataCart) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (cubit.cartProductList.isEmpty) {
//             return Center(
//               child: Text(
//                 "There Are No Cart Products",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           } else {
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await cubit.getCartProducts(); // Refresh the favorites
//               },
//               child: GridView.builder(
//                 itemCount: cubit.cartProductList.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 1.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return CartCard(
//                     productModel: cubit.cartProductList[index],
//                     onPressed: () async {
//                       await cubit.addOrRemoveFromCart(
//                           productID: cubit.cartProductList[index].id);
//                     },
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:ecommerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/cubits/cart_cubit/cart_states.dart';
import 'package:ecommerce/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize cart products fetch when the widget builds for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CartCubit>(context).getCartProducts();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart Products",
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is SuccessAddOrRemoveFromCart) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cart updated successfully'),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is ErrorAddOrRemoveFromCart) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<CartCubit>(context);

          if (state is LoadingGetDataCart) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (cubit.cartProductList.isEmpty) {
            return const Center(
              child: Text(
                "There Are No Cart Products",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getCartProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cubit.cartProductList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (context, index) {
                final product = cubit.cartProductList[index];
                return CartCard(
                  productModel: product,
                  onPressed: () async {
                    await cubit.addOrRemoveFromCart(productID: product.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
