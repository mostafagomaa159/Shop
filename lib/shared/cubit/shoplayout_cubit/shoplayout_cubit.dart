import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/models/home_model.dart';
import 'package:shopapplication/modules/categories/categories_screen.dart';
import 'package:shopapplication/modules/favorites/favorites_screen.dart';
import 'package:shopapplication/modules/products/products_screen.dart';
import 'package:shopapplication/modules/settings/settings_screen.dart';
import 'package:shopapplication/shared/components/constance.dart';
import 'package:shopapplication/shared/cubit/shoplayout_cubit/shoplayout_states.dart';
import 'package:shopapplication/shared/network/end_points.dart';
import 'package:shopapplication/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex =index;
    emit(ShopChangeBottomNavState());
  }
HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      homeModel=HomeModel.fromJson(value!.data);
      printFullText(homeModel!.data!.banners![0].image!);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

}

