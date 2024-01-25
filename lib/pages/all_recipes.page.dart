import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/recipes.provider.dart';
import 'package:recipe_app/widgets/recipe_widget.dart';

class AllRecipesPage extends StatefulWidget {
  const AllRecipesPage({super.key});

  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<RecipesProvider>(
            builder: (ctx, recipesProvider, _) =>
                recipesProvider.recipesList == null
                    ? const CircularProgressIndicator()
                    : (recipesProvider.recipesList?.isEmpty ?? false)
                        ? const Text('No Data Found')
                        : FlexibleGridView(
                            children: recipesProvider.recipesList!
                                .map((e) => RecipeWidget(recipe: e))
                                .toList(),
                            axisCount: GridLayoutEnum.twoElementsInRow,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          )));
  }
}
