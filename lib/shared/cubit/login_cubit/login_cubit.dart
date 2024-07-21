import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/models/login_model.dart';
import 'package:shopapplication/shared/network/end_points.dart';
import 'package:shopapplication/shared/network/remote/dio_helper.dart';
import 'login_states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      shopLoginModel= ShopLoginModel.fromJson(value.data);
      print(shopLoginModel?.message);
      print(shopLoginModel?.status);
      print(shopLoginModel?.data?.token);
      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibility());
  }
}
