import 'package:ecommerce/cubits/auth_cubit/login_cubit/login_cubit.dart';
import 'package:ecommerce/cubits/auth_cubit/register_cubit/register_cubit.dart';
import 'package:ecommerce/cubits/favorite_cubit/favourite_cubet.dart';
import 'package:ecommerce/cubits/layout_cubit/layout_cubit.dart';
import 'package:ecommerce/pages/authintiction_page.dart';
import 'package:ecommerce/pages/layout_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/pages/register_page.dart';
import 'package:ecommerce/pages/splash_page.dart';
import 'package:ecommerce/services/shared_prefrences_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefrencesService.intialSharedpref();

  runApp(Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
          BlocProvider<LayoutCubit>(
            create: (context) => LayoutCubit(),
          ),
          BlocProvider<FavouriteCubit>(
            create: (context) => FavouriteCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            // brightness: Brightness.dark,
          ),
          routes: {
            SplashPage.id: (context) => SplashPage(),
            LayoutPage.id: (context) => LayoutPage(),
            RegisterPage.id: (context) => RegisterPage(),
            LoginPage.id: (context) => LoginPage(),
            AuthintictionPage.id: (context) => AuthintictionPage(),
          },
          initialRoute: SplashPage.id,
        ),
      );
    });
  }
}
