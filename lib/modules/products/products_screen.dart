import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapplication/models/home_model.dart';
import 'package:shopapplication/shared/cubit/shoplayout_cubit/shoplayout_cubit.dart';
import 'package:shopapplication/shared/cubit/shoplayout_cubit/shoplayout_states.dart';
import 'package:shopapplication/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) => productsBuilder(cubit.homeModel!),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.55,
                crossAxisCount: 2,
                children: List.generate(model.data!.products!.length,
                    (index) => buildGridProducts(model.data!.products![index])),
              ),
            ),
          ],
        ),
      );
  Widget buildGridProducts(Products model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.image!),
                  width: double.infinity,
                  height: 200,
                  //fit: BoxFit.cover,
                ),
                if (model.oldPrice != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                          //  height: 1.3
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.oldPrice != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                              //  height: 1.3
                              ),
                        ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            size: 14,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
}
