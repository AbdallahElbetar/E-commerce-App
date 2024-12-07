import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';
import 'package:ecommerce/widgets/profile_body.dart';

import 'package:flutter/material.dart';

import 'package:ecommerce/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<LayoutCubit>().getUserData();
    BlocProvider.of<LayoutCubit>(context).getUserData();

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SuccessUserDataState) {
          final UserModel userModel = state.userModel;

          return profile_body(UserData: userModel);
        } else if (state is FailureUserDataState) {
          return Center(
            child: Text("Oops,${state.message}"),
          );
        } else {
          print(SharedPrefrencesService.getFromCache(key: "token"));

          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}
