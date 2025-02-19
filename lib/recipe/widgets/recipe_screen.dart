import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RecipeScreen extends StatelessWidget {
  final int recipeIndex;
  final String? assignedFoodItemId;
  const RecipeScreen(this.recipeIndex, {Key? key, this.assignedFoodItemId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: assignedFoodItemId == null
                ? const Text('Add a new recipe')
                : const Text('Confirm chosen recipe'),
            leading: BackButton(
                onPressed: () => {
                      context.read<RecipeBloc>().add(const RecipesSaved()),
                      Navigator.pop(context)
                    }),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, PageRouter.recipeProbe,
                      arguments: recipeIndex),
                  icon: const Icon(Icons.help))
            ],
          ),
          body: RecipeForm(recipeIndex),
          floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: assignedFoodItemId == null
                        ? const Text("Save Recipe")
                        : const Text("Choose Recipe"),
                    icon: assignedFoodItemId == null
                        ? const Icon(Icons.save_sharp)
                        : const Icon(Icons.check),
                    onPressed: () {
                      if (assignedFoodItemId == null) {
                        context.read<RecipeBloc>().add(RecipeStatusChanged(
                            recipe: state.recipes[recipeIndex],
                            recipeSaved: true));
                        context.read<RecipeBloc>().add(const RecipesSaved());
                        Navigator.pop(context);
                      } else {
                        context.read<CollectionBloc>().add(
                            FoodItemRecipeChanged(
                                foodItemId: assignedFoodItemId!,
                                foodItemRecipe: state.recipes[recipeIndex]));
                        context.read<RecipeBloc>().add(const RecipesSaved());
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                    heroTag: null,
                    label: const Text("New Ingredient"),
                    icon: const Icon(Icons.add),
                    onPressed: () => {
                          context.read<RecipeBloc>().add(IngredientAdded(
                              recipe: state.recipes[recipeIndex])),
                          Navigator.pushNamed(context, PageRouter.ingredient,
                              arguments: [
                                recipeIndex,
                                state.recipes[recipeIndex].ingredients.length
                              ]),
                        })
              ]));
    });
  }
}

class RecipeForm extends StatelessWidget {
  final int recipeIndex;
  const RecipeForm(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          RecipeNameInput(recipeIndex),
          RecipeNumberInput(recipeIndex),
          RecipeVolumeInput(recipeIndex),
          Ingredients(recipeIndex),
        ],
      ),
    );
  }
}

class RecipeNameInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeNameInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipes[recipeIndex].recipeName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.assignment_rounded),
            labelText: 'Recipe Name',
            helperText: 'A valid recipe name, e.g. Aloo bandhgobhi',
            errorText: state.recipes[recipeIndex].recipeName.invalid
                ? 'Enter a valid recipe name, e.g. Aloo bandhgobhi'
                : null,
          ),
          onChanged: (value) {
            context.read<RecipeBloc>().add(RecipeNameChanged(
                recipeName: value, recipe: state.recipes[recipeIndex]));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RecipeNumberInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeNumberInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          key: Key(state.recipes[recipeIndex].recipeNumber),
          initialValue: state.recipes[recipeIndex].recipeNumber,
          decoration: const InputDecoration(
            icon: Icon(Icons.format_list_numbered),
            labelText: 'Recipe Number',
          ),
          enabled: false,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class RecipeVolumeInput extends StatelessWidget {
  final int recipeIndex;
  const RecipeVolumeInput(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.recipes[recipeIndex].recipeVolume.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: const Icon(Icons.play_for_work_rounded),
            labelText: 'Recipe Volume',
            helperText: 'Volume of recipe in ml e.g 250 ml',
            errorText: state.recipes[recipeIndex].recipeVolume.invalid
                ? 'Enter valid volume'
                : null,
          ),
          onChanged: (value) {
            context.read<RecipeBloc>().add(RecipeVolumeChanged(
                recipeVolume: value, recipe: state.recipes[recipeIndex]));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class Ingredients extends StatelessWidget {
  final int recipeIndex;
  const Ingredients(this.recipeIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(2.0),
              itemCount: state.recipes[recipeIndex].ingredients.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DeleteIngredient(
                                      recipe: state.recipes[recipeIndex],
                                      ingredient: state.recipes[recipeIndex]
                                          .ingredients[index]));
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: Card(
                      child: ListTile(
                    title: Text(state
                        .recipes[recipeIndex].ingredients[index].name.value),
                    subtitle: Text(state.recipes[recipeIndex].ingredients[index]
                        .description.value),
                    leading: const Icon(Icons.food_bank),
                    trailing:
                        state.recipes[recipeIndex].ingredients[index].saved
                            ? const Icon(Icons.done)
                            : const Icon(Icons.rotate_left_rounded),
                    onTap: () => {
                      Navigator.pushNamed(context, PageRouter.ingredient,
                          arguments: [recipeIndex, index])
                    },
                  )),
                );
              }));
    });
  }
}

class DeleteIngredient extends StatelessWidget {
  final Recipe recipe;
  final Ingredient ingredient;

  const DeleteIngredient(
      {Key? key, required this.recipe, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ingredientName = ingredient.name.value;
    return BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
      return AlertDialog(
        title: const Text('Delete ingredient'),
        content:
            Text('Would you like to delete the $ingredientName ingredient?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              context.read<RecipeBloc>().add(
                  IngredientDeleted(recipe: recipe, ingredient: ingredient)),
              Navigator.pop(context, 'OK')
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
