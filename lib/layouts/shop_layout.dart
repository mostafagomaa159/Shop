import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/modules/login/shop_login_screen.dart';
import 'package:shopapplication/modules/search/search_screen.dart';
import 'package:shopapplication/shared/components/components.dart';
import 'package:shopapplication/shared/cubit/app_cubit/cubit.dart';
import 'package:shopapplication/shared/cubit/shoplayout_cubit/shoplayout_cubit.dart';
import 'package:shopapplication/shared/cubit/shoplayout_cubit/shoplayout_states.dart';
import 'package:shopapplication/shared/network/local/cashe_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        ShopCubit cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.exit_to_app),
                iconSize: 30,
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
