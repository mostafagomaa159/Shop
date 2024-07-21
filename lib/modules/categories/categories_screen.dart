import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Categories Screen',style: Theme.of(context).textTheme.titleLarge,));
  }
}
