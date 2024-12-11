import 'package:ecommerce/api/home_page_services.dart';

import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/models/banner_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/widgets/build_categories_section.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:ecommerce/widgets/search_bar_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  final PageController pc = PageController();
  final TextEditingController controller = TextEditingController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getHomeProduct();

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SearchBarField(
                controller: controller,
                onChanged: (value) {
                  context.read<LayoutCubit>().fliterProductData(input: value);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              buildBannerSection(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              buildPageIndicator(state),
              buildCategoriesHeader(),
              BuildCategoriesSection(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              buildProductSection(state, context, cubit),
            ],
          ),
        );
      },
    );
  }

  Widget buildPageIndicator(LayoutStates state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothPageIndicator(
          controller: pc,
          count:
              3, // You may want to adjust this based on actual banner data length
          effect: WormEffect(
            dotHeight: 16,
            dotWidth: 16,
            type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }

  Widget buildBannerSection(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: HomePageServices().getBannerData(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        } else if (snapShot.hasError) {
          return Center(
              child: Text("Error fetching banners: ${snapShot.error}"));
        } else if (snapShot.hasData) {
          List<BannerModel> bannerData = snapShot.data!;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: pc,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: (index > 0) ? 10 : 0),
                  child: Image.network(
                    bannerData[index].image,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image,
                            color: Colors.black, size: 50),
                      );
                    },
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: bannerData.length,
            ),
          );
        } else {
          return Center(child: Text("No banners available"));
        }
      },
    );
  }

  Widget buildCategoriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        TextButton(
          onPressed: () {},
          child: Text("View All", style: TextStyle(color: Colors.indigo)),
        ),
      ],
    );
  }

  Widget buildProductSection(
    LayoutStates state,
    BuildContext context,
    LayoutCubit cubit,
  ) {
    if (state is SuccessGetProductState || state is SuccessFiltterData) {
      List<ProductModel> productData = cubit.productDataListWillFiltter;
      List<ProductModel> filteredProductData =
          cubit.productFilttered; // Use cubit filtered data

      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredProductData.isNotEmpty
            ? filteredProductData.length
            : productData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: .7,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            productModel: filteredProductData.isNotEmpty
                ? filteredProductData[index]
                : productData[index],
          );
        },
      );
    } else if (state is LoadingGetProductState) {
      return Center(child: CupertinoActivityIndicator(radius: 25));
    } else {
      return Center(child: Text("Failure to get data"));
    }
  }
}
