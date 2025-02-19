import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SecondPassScreen extends StatelessWidget {
  const SecondPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: const Text('Second Pass'),
              leading: BackButton(
                onPressed: () {
                  context.read<CollectionBloc>().add(const GibsonsFormSaved());
                  context.read<HomeBloc>().add(const GibsonsFormsLoaded());
                  Navigator.maybePop(context);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRouter.secondPassHelp),
                    icon: const Icon(Icons.help))
              ]),
          body: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.gibsonsForm.foodItems.length,
              itemBuilder: (context, index) {
                return SecondPassFoodItemCard(
                  foodItem: state.gibsonsForm.foodItems[index],
                  onSourceChanged: (changedSource) => context
                      .read<CollectionBloc>()
                      .add(FoodItemSourceChanged(
                          foodItem: state.gibsonsForm.foodItems[index],
                          foodItemSource: changedSource)),
                  onDescriptionChanged: (changedDescription) => context
                      .read<CollectionBloc>()
                      .add(FoodItemDescriptionChanged(
                          foodItem: state.gibsonsForm.foodItems[index],
                          foodItemDescription: changedDescription)),
                  onPreparationMethodChanged: (changedPreparationMethod) =>
                      context.read<CollectionBloc>().add(
                          FoodItemPreparationMethodChanged(
                              foodItem: state.gibsonsForm.foodItems[index],
                              foodItemPreparationMethod:
                                  changedPreparationMethod)),
                );
              }),
        );
      },
    );
  }
}
