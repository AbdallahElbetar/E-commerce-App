import 'package:ecommerce/cubits/auth_cubit/login_cubit/login_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/register_cubit/register_cubit.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/pages/register_page.dart';
import 'package:ecommerce/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          SplashPage.id: (context) => SplashPage(),
          HomePage.id: (context) => HomePage(),
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}
