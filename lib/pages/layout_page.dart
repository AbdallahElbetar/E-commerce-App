import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutPage extends StatelessWidget {
  static String id = "Layoutpage";

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Row(
              children: [
                Image.asset("lib/assets/images/logo.png"),
                Text(
                  "Fashion",
                  style: TextStyle(color: Colors.pink),
                )
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: cubit.indexBottomNavBar,
            items: [
              Icon(Icons.home),
              Icon(Icons.category),
              Icon(Icons.favorite),
              Icon(Icons.shopping_cart),
              Icon(Icons.person),
            ],
            animationDuration: Duration(milliseconds: 300),
            onTap: (value) {
              cubit.bottomNavChanged(value: value);
            },
          ),
          body: cubit.layoutListView[cubit.indexBottomNavBar],
        );
      },
    );
  }
}
