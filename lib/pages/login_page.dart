import 'package:ecommerce/cubits/auth_cubit/login_cubit/login_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/login_cubit/login_states.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/pages/home_page.dart';

import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String id = "LoginPage";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamed(context, HomePage.id);
          emailController.clear();
          passwordController.clear();
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 4),
              content: Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
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
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "lib/assets/images/loginImage.jpg",
              ),
            )),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .09,
                          ),
                          Text(
                            "Login to Continue Process",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.indigo, fontSize: 20),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          CustomTextFormField(
                              hintText: "Email",
                              labelText: "Email",
                              isPassword: false,
                              inputType: TextInputType.emailAddress,
                              controller: emailController),
                          CustomTextFormField(
                              hintText: "Password",
                              labelText: "PassWord",
                              isPassword: true,
                              inputType: TextInputType.visiblePassword,
                              controller: passwordController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                // context.read<LoginCubit>().loginUser(email: emailController.text, password: passwordController.text);

                                BlocProvider.of<LoginCubit>(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            CustomWidget: (state is LoginLoadingState)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forget Your Password ? ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () {}, child: Text("Click here"))
                            ],
                          )
                        ],
                      ),
                    ),
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
