import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/modules/login/shop_login_screen.dart';
import 'package:shopapplication/shared/cubit/app_cubit/states.dart';
import 'package:shopapplication/shared/network/local/cashe_helper.dart';
import '../../components/components.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(ShopInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/on_boarding_2.png',
        title: 'Screen Title',
        body: 'Screen Body'),
    BoardingModel(
        image: 'assets/images/on_boarding_2.png',
        title: 'Screen Title 2',
        body: 'Screen Body 2'),
    BoardingModel(
        image: 'assets/images/on_boarding_2.png',
        title: 'Screen Title 3',
        body: 'Screen Body 3'),
  ];
  bool isDark = false;
  void submit(context) {
    SharedPrefrenceHelper.saveData(key: 'onBoarding', value: true)
        .then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeAppModeState());
    } else {
      isDark = !isDark;
      SharedPrefrenceHelper.saveData(key: 'isDark', value: isDark)
          .then((value) {
        emit(ShopChangeAppModeState());
      });
    }
  }

  bool isLast=false;
  void moveToLoginScreen(context,{required bool? isLast,required PageController controller}){
    if (isLast==true) {
      navigateAndFinish(context, ShopLoginScreen());
      emit(FloatingActionButtomSuccessState());
    } else
    {
      controller.nextPage(
          duration: Duration(milliseconds: 750),
          curve: Curves.fastLinearToSlowEaseIn);
      emit(FloatingActionButtomFailedState());
    }
  }

}