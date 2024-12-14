import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/models/user_model.dart';

import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/pages/update_data_page.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profile_body extends StatelessWidget {
  final UserModel userModel;
  const profile_body({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    var layOutCubit = BlocProvider.of<LayoutCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 55,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: Image.network(
                  userModel.image,
                  fit: BoxFit.contain,
                ),
              )),
          Text(
            userModel.name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            userModel.email,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black26,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    UpdateDataPage.id,
                  );
                },
                CustomWidget: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Text(
                      "Update Data",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
                onTap: () {},
                CustomWidget: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Text(
                      "Others",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: CustomButton(
                onTap: () {},
                CustomWidget: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Text(
                      "Favourits",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: BlocConsumer<LayoutCubit, LayoutStates>(
              bloc: layOutCubit,
              listener: (context, state) async {
                if (state is SuccessLogOutUserState) {
                } else if (state is FailureLogOutUserState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return CustomButton(
                    onTap: () {
                      layOutCubit.logOutUser(
                        fcmToken:
                            SharedPrefrencesService.getFromCache(key: "token"),
                      );
                      Navigator.pushReplacementNamed(context, LoginPage.id);
                    },
                    CustomWidget: Row(
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        (state is LoadingLogOutUserState)
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Log Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                        Spacer(
                          flex: 4,
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
