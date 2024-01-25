import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/recipe.model.dart';
import 'package:recipe_app/pages/favourites.page.dart';
import 'package:recipe_app/pages/filter.page.dart';
import 'package:recipe_app/pages/ingredietnt.page.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/provider/recipes.provider.dart';
import 'package:recipe_app/services/meal.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/numbers.dart';
import 'package:recipe_app/widgets/ads_widget.dart';
import 'package:recipe_app/widgets/recipe_widget.dart';
import 'package:recipe_app/widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    Provider.of<RecipesProvider>(context, listen: false).getFreshRecipes();
    Provider.of<RecipesProvider>(context, listen: false)
        .getRecommandedRecipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: Colors.white,
      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      disableDragGesture: true,
      mainScreenTapClose: true,
      controller: controller,
      drawerShadowsBackgroundColor: Colors.grey,
      menuScreen: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                onTap: () {
                  controller.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FilterPage()));
                },
                leading: const Icon(Icons.search),
                title: const Text('Filter'),
              ),
              ListTile(
                onTap: () {
                  controller.close?.call();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FavouritesPage()));
                },
                leading: const Icon(Icons.favorite_outlined),
                title: const Text('Favourites'),
              ),
              ListTile(
                onTap: () {
                  controller.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => IngredientPage()));
                },
                leading: Icon(Icons.food_bank),
                title: Text('Ingredients'),
              ),
              ListTile(
                onTap: () {
                  Provider.of<AppAuthProvider>(context, listen: false)
                      .signOut(context);
                },
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              )
            ],
          ),
        ),
      ),
      mainScreen: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
            child: InkWell(
                onTap: () {
                  controller.toggle!();
                },
                child: Icon(Icons.menu)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Numbers.appHorizontalPadding),
              child: Icon(Icons.notifications),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AdsWidget(),
                SectionHeader(sectionName: 'Today\'s Fresh Recipes'),
                SizedBox(
                  height: 300,
                  child: Consumer<RecipesProvider>(
                      builder: (ctx, recipesProvider, _) => recipesProvider
                                  .freshRecipesList ==
                              null
                          ? const CircularProgressIndicator()
                          : (recipesProvider.freshRecipesList?.isEmpty ?? false)
                              ? const Text('No Data Found')
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      recipesProvider.freshRecipesList!.length,
                                  itemBuilder: (ctx, index) => RecipeWidget(
                                        recipe: recipesProvider
                                            .freshRecipesList![index],
                                      ))),
                ),
                SectionHeader(sectionName: 'New Ingredients'),
                FlutGroupedButtons<String>(
                  isRadio: true,
                  selectedList: ["launch"],
                  data: MealTypes.values.map((e) => e.name).toList(),
                  onChanged: (name) {
                    print(name);
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      OverlayLoadingProgress.start();

                      var imageResult = await FilePicker.platform
                          .pickFiles(type: FileType.image, withData: true);

                      var refresnce = FirebaseStorage.instance
                          .ref('reciepes/${imageResult?.files.first.name}');

                      if (imageResult?.files.first.bytes != null) {
                        var uploadResult = await refresnce.putData(
                            imageResult!.files.first.bytes!,
                            SettableMetadata(contentType: 'image/png'));

                        if (uploadResult.state == TaskState.success) {
                          print(
                              '?????image upload successfully ${await refresnce.getDownloadURL()}');
                        }
                      }

                      OverlayLoadingProgress.stop();
                    },
                    child: Text('upload image')),
              ],
            ),
          ),
        ),
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: -9.0,
    );
  }
}
