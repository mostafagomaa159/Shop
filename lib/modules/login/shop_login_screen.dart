import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapplication/layouts/shop_layout.dart';
import 'package:shopapplication/modules/shop_register_screen/register_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapplication/shared/components/components.dart';
import 'package:shopapplication/shared/cubit/login_cubit/login_cubit.dart';
import 'package:shopapplication/shared/cubit/login_cubit/login_states.dart';
import 'package:shopapplication/shared/network/local/cashe_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status!) {
            print(state.loginModel.data?.token);
            SharedPrefrenceHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                .then((value) {
              navigateAndFinish(context, ShopLayout());
            });
            showToast(
                text: state.loginModel.message!, state: ToastStates.SUCCESS);
          } else {
            showToast(
                text: state.loginModel.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailController,
                        Type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        Type: TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please is to short";
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don\'t have an account?"),
                          defaultTextButton(
                              text: "register",
                              onPressed: () {
                                navigateTo(context, const ShopRegisterScreen());
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
