import 'package:ecommerce/cubits/auth_cubit/register_cubit/register_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/register_cubit/register_states.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = "RegisterPage";
  GlobalKey<FormState> formkey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterFaluireState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )),
          );
        } else if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Text(
                    "Success",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                CustomTextFormField(
                    controller: nameController,
                    hintText: "User Name",
                    labelText: "User Name",
                    isPassword: false,
                    inputType: TextInputType.name),
                CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    labelText: "Email",
                    isPassword: false,
                    inputType: TextInputType.emailAddress),
                CustomTextFormField(
                    controller: phoneController,
                    hintText: "Phone",
                    labelText: "Phone",
                    isPassword: false,
                    inputType: TextInputType.emailAddress),
                CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    labelText: "Password",
                    isPassword: true,
                    inputType: TextInputType.visiblePassword),
                CustomButton(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      {
                        BlocProvider.of<RegisterCubit>(context).register(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text,
                        );
                      }
                    } else {}
                  },
                  CustomWidget: (state is RegisterLoadingState)
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login In",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
