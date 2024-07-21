import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
            child: Text(
      'Search Screen',
      style: Theme.of(context).textTheme.titleLarge,
    )));
  }
}
