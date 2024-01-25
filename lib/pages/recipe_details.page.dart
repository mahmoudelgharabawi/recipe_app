import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/ingredient.model.dart';
import 'package:recipe_app/models/recipe.model.dart';
import 'package:recipe_app/provider/recipes.provider.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailsPage({required this.recipe, super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false)
        .addRecipeToUserRecentlyViewed(widget.recipe.docId!);
    super.initState();
  }

  bool get isInList => (widget.recipe.favourite_users_ids
          ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
      false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
      ),
      body: ListTile(
          subtitle: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('ingredients')
                  .where('users_ids',
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  var userIngredients = List<Ingredient>.from(snapShot
                      .data!.docs
                      .map((e) => Ingredient.fromJson(e.data(), e.id))
                      .toList());

                  var userIngredientsTitles =
                      userIngredients.map((e) => e.name).toList();
                  Widget checkIngredientWidget(String recipeIngredient) {
                    bool isExsist = false;
                    for (var userIngredientsTitle in userIngredientsTitles) {
                      if (recipeIngredient.contains(userIngredientsTitle!)) {
                        isExsist = true;
                        break;
                      } else {
                        isExsist = false;
                      }
                    }

                    if (isExsist) {
                      return Icon(Icons.check);
                    } else {
                      return Icon(Icons.close);
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.recipe.ingredients
                              ?.map((e) => Row(
                                    children: [
                                      Text(e),
                                      checkIngredientWidget(e)
                                    ],
                                  ))
                              .toList() ??
                          [],
                    ),
                  );
                }
              }),
          title: Text(widget.recipe.title ?? 'No Title'),
          trailing: InkWell(
              onTap: () {
                Provider.of<RecipesProvider>(context, listen: false)
                    .addRecipeToUserFavourite(widget.recipe.docId!, !isInList);

                if (isInList) {
                  widget.recipe.favourite_users_ids
                      ?.remove(FirebaseAuth.instance.currentUser?.uid);
                } else {
                  widget.recipe.favourite_users_ids
                      ?.add(FirebaseAuth.instance.currentUser!.uid);
                }

                setState(() {});
              },
              child: isInList
                  ? const Icon(
                      Icons.favorite_border_rounded,
                      size: 30,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: Colors.grey,
                    ))),
    );
  }
}
