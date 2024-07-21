
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/modules/login/shop_login_screen.dart';
import 'package:shopapplication/shared/components/components.dart';
import 'package:shopapplication/shared/cubit/app_cubit/cubit.dart';
import 'package:shopapplication/shared/cubit/app_cubit/states.dart';
import 'package:shopapplication/shared/network/local/cashe_helper.dart';
import 'package:shopapplication/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  var boardController = PageController();

  OnBoardingScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(
                  onPressed:(){
                    SharedPrefrenceHelper.saveData(key: 'onBoarding', value: true)
                        .then((value) {
                      if (value) {
                        navigateAndFinish(context, ShopLoginScreen());
                      }
                    });
                  },
                  text: "skip")
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == cubit.boarding.length - 1) {
                        cubit.isLast = true;
                      } else {
                        cubit.isLast = false;
                      }
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(cubit.boarding[index]),
                    itemCount: cubit.boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5,
                          activeDotColor: defaultColor,
                        ),
                        controller: boardController,
                        count: cubit.boarding.length),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if(cubit.isLast){
                          cubit.submit(context);
                        }else{
                          AppCubit.get(context).moveToLoginScreen(context,
                              controller: boardController, isLast: cubit.isLast);
                        }

                      },
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
