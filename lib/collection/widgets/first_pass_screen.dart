import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class FirstPassScreen extends StatelessWidget {
  const FirstPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('First Pass'),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRouter.firstPassHelp),
                    icon: const Icon(Icons.help))
              ],
            ),
            // TODO: atomize into smaller widgets
            body: ListView.builder(
                padding: const EdgeInsets.all(2.0),
                itemCount: state.foodItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            // A unique key needs to be set in order to properly
                            // rebuild this Field after deleting a FoodItem
                            key: Key(state.foodItems[index].id),
                            initialValue: state.foodItems[index].name.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.fastfood),
                              labelText: 'Food name',
                              helperText: 'Food name e.g. Dhal',
                              errorText: state.foodItems[index].name.invalid
                                  ? 'Enter a food name e.g. Banana'
                                  : null,
                            ),
                            onChanged: (value) {
                              context.read<CollectionBloc>().add(
                                  FoodItemNameChanged(
                                      foodItem: state.foodItems[index],
                                      foodItemName: value));
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          DropdownButtonFormField(
                            value: state.foodItems[index].timePeriod.value,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.access_time),
                              labelText: 'Time period',
                              helperText:
                                  'Time period of consuming the food e.g. Morning',
                              errorText:
                                  state.foodItems[index].timePeriod.invalid
                                      ? 'Select a time period'
                                      : null,
                            ),
                            items: const [
                              // TODO: research how to handle empty string as
                              // the selected value other than a blank menu item
                              DropdownMenuItem(child: Text(''), value: ''),
                              DropdownMenuItem(
                                  child: Text('Morning'), value: 'Morning'),
                              DropdownMenuItem(
                                  child: Text('Afternoon'), value: 'Afternoon'),
                              DropdownMenuItem(
                                  child: Text('Evening'), value: 'Evening'),
                              DropdownMenuItem(
                                  child: Text('Night'), value: 'Night'),
                            ],
                            onChanged: (String? value) {
                              context
                                  .read<CollectionBloc>()
                                  .add(FoodItemTimePeriodChanged(
                                      foodItem: state.foodItems[index],
                                      // TODO: Make a better null check
                                      foodItemTimePeriod: value ?? ''));
                            },
                          ),
                          const Divider(),
                          // TODO: Make a pop-up with a confirmation box
                          //for deleting an item
                          TextButton(
                              onPressed: () => context
                                  .read<CollectionBloc>()
                                  .add(FoodItemDeleted(
                                      foodItem: state.foodItems[index])),
                              child: const Text('Delete'))
                        ],
                      ),
                    ),
                  );
                }),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () =>
                          context.read<CollectionBloc>().add(FoodItemAdded()))
                ]));
      },
    );
  }
}
