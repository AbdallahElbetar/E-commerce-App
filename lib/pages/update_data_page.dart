import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_states.dart';
import 'package:ecommerce/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UpdateDataPage extends StatelessWidget {
  UpdateDataPage({super.key});
  static String id = "UpdateData";
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is SuccessChangePasswordUserState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Text(state.message),
                ],
              ),
            ),
          );
        } else if (state is FailureChangePasswordUserState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    Text(state.error),
                  ],
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            centerTitle: true,
            title: Text(
              "Update Data",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Change Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                  CustomTextFormField(
                    hintText: "Current Password",
                    labelText: 'Current Password',
                    controller: currentPasswordController,
                    isPassword: false,
                    inputType: TextInputType.visiblePassword,
                  ),
                  CustomTextFormField(
                    hintText: "New Password",
                    labelText: 'New Password',
                    controller: newPasswordController,
                    isPassword: false,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.changePasswordUser(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text);
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              (state is LoadingChangePasswordUserState)
                                  ? "Loading..."
                                  : "Change Passwprd",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
