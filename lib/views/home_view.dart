import 'package:ecommerce/api/home_page_services.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/models/categories_model.dart';

import 'package:ecommerce/widgets/search_bar_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final PageController pc = PageController();
  var futureCategoryData = HomePageServices().getCategoriesData();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getBannerData();

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 8), // Constant height for spacing
              SearchBarField(),
              buildBannerSection(state, context),
              SizedBox(height: 8), // Constant height for spacing
              buildPageIndicator(state),
              buildCategoriesHeader(),
              buildCategoriesSection(state, context),
            ],
          ),
        );
      },
    );
  }

  Widget buildBannerSection(LayoutStates state, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: (state is SuccessGetBannerState)
          ? PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: pc,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: (index > 0) ? 10 : 0),
                  child: Image.network(
                    state.bannerData[index].image,
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: state.bannerData.length,
            )
          : Center(child: CupertinoActivityIndicator(radius: 25)),
    );
  }

  Widget buildPageIndicator(LayoutStates state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothPageIndicator(
          controller: pc,
          count: (state is SuccessGetBannerState) ? state.bannerData.length : 1,
          effect: WormEffect(
            dotHeight: 16,
            dotWidth: 16,
            type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }

  Widget buildCategoriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "View All",
            style: TextStyle(color: Colors.indigo),
          ),
        ),
      ],
    );
  }

  Widget buildCategoriesSection(LayoutStates state, BuildContext context) {
    return FutureBuilder<List<CategoriesModel>>(
        future: futureCategoryData,
        builder: (context, AsyncSnapshot snapShot) {
          if (snapShot.hasData) {
            List<CategoriesModel> categoriesData = snapShot.data;
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesData.length,
                  itemBuilder: (context, index) {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(categoriesData[index].image),
                    );
                  }),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
        });
  }
}
