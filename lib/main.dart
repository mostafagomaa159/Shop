import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapplication/layouts/shop_layout.dart';
import 'package:shopapplication/modules/login/shop_login_screen.dart';
import 'package:shopapplication/shared/cubit/app_cubit/cubit.dart';
import 'package:shopapplication/shared/style/colors.dart';
import 'modules/on_boarding/on_boarding_screens.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/components/constance.dart';
import 'shared/cubit/app_cubit/states.dart';
import 'shared/cubit/login_cubit/login_cubit.dart';
import 'shared/cubit/shoplayout_cubit/shoplayout_cubit.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefrenceHelper.init();
  Widget widget;
  var onBoarding = SharedPrefrenceHelper.getData(key: 'onBoarding');
   token = SharedPrefrenceHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  //const MyApp(this.isDark, {super.key});
  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => ShopLoginCubit()),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defaultColor,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: defaultColor,
                  elevation: 20.0,
                  backgroundColor: Colors.white),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                ),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              fontFamily: "Mukta",
            ),
            darkTheme: ThemeData(
              primarySwatch: defaultColor,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.blue),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor("333739"),
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backgroundColor: HexColor("333739"),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor("333739"),
                  statusBarBrightness: Brightness.light,
                ),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
              useMaterial3: true,
              scaffoldBackgroundColor: HexColor("333739"),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              fontFamily: "Mukta",
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            //Directionality(textDirection: TextDirection.rtl,child: NewsLayout()),
          );
        },
      ),
    );
  }
}
