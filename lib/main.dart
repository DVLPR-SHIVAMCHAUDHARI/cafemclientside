import 'package:cafem2/controller/authController.dart';
import 'package:cafem2/controller/foodController.dart';
import 'package:cafem2/firebase_options.dart';
import 'package:cafem2/views/auth/forgotPassword.dart';
import 'package:cafem2/views/auth/signinscreen.dart';
import 'package:cafem2/views/auth/signupscreen.dart';
import 'package:cafem2/views/cartScreen.dart';
import 'package:cafem2/views/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

enum Routes { splash, signin, signnup, homescreen, forgotpass, cart }

final navigatorKey = GlobalKey<NavigatorState>();
BuildContext get appContext => navigatorKey.currentState!.context;

Logger logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(cafem2());
}

class cafem2 extends StatelessWidget {
  cafem2({super.key});

  GoRouter router = GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      path: '/',
      name: Routes.signin.name,
      builder: (context, state) =>
          AuthController().isLogin ? HomeScreen() : const SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: Routes.signnup.name,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
        path: '/home',
        name: Routes.homescreen.name,
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: '/cart',
            name: Routes.cart.name,
            builder: (context, state) => Cartscreen(),
          )
        ]),
    GoRoute(
      path: '/forgot',
      name: Routes.forgotpass.name,
      builder: (context, state) => Forgotpassword(),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthController()),
          ChangeNotifierProvider(create: (_) => FoodController()),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
