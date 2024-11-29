import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final pc = PageController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    cubit.getBannerData();
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .25,
                width: double.infinity,
                child: (state is SuccessGetBannerState)
                    ? PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: pc,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: (index > 0)
                                ? EdgeInsets.only(right: 10)
                                : EdgeInsets.all(0),
                            child: Image.network(
                              state.bannerData[index].image,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        itemCount: state.bannerData.length,
                      )
                    : Center(
                        child: CupertinoActivityIndicator(
                          radius: 25,
                          color: Colors.black,
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),
              SmoothPageIndicator(
                controller: pc,
                count: (state is SuccessGetBannerState)
                    ? state.bannerData.length
                    : 1,
                effect: const WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thinUnderground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
