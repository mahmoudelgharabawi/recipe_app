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
import 'package:recipe_app/pages/ingredietnt.page.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/services/meal.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/numbers.dart';
import 'package:recipe_app/widgets/ads_widget.dart';
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
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('recipes')
                          .get(),
                      builder: (ctx, snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapShot.hasError) {
                            return const Text('error in get data');
                          } else {
                            if (snapShot.hasData) {
                              if (snapShot.data?.docs.isNotEmpty ?? false) {
                                var recipesList = List<Recipe>.from(
                                    snapShot.data?.docs.map((e) =>
                                            Recipe.fromJson(e.data(), e.id)) ??
                                        []);

                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: recipesList.length,
                                    itemBuilder: (ctx, index) => Text(
                                        jsonEncode(recipesList[index]
                                                .directions) ??
                                            'no title found'));
                                // ListTile(
                                //       title: Text(
                                //           recipesList[index].title ??
                                //               'no title found'),
                                //     ))

                                // logic
                              } else {
                                return const Text('No Data Found');
                              }
                            } else {
                              return const Text('No Data Found');
                            }
                          }
                        }
                      }),
                ),
                // Card(
                //   elevation: 2,
                //   child: Container(
                //       width: 240,
                //       decoration: BoxDecoration(
                //           color: Color(
                //             ColorsConst.containerBackgroundColor,
                //           ),
                //           borderRadius: BorderRadius.circular(20)),
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //             top: 15, bottom: 15, left: 15),
                //         child: Column(
                //           children: [
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Icon(
                //                   Icons.favorite_outline,
                //                   color: Colors.grey,
                //                 ),
                //                 Transform.translate(
                //                   offset: Offset(20, 0),
                //                   child: Image.asset(
                //                     'assets/images/frensh_toast.png',
                //                     height: 140,
                //                     width: 200,
                //                     fit: BoxFit.fitHeight,
                //                   ),
                //                 )
                //               ],
                //             ),
                //             Column(
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text(
                //                       'Breakfast',
                //                       style: TextStyle(
                //                           color: Color(0xff1F95B3),
                //                           fontSize: 13),
                //                     ),
                //                   ],
                //                 ),
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.symmetric(vertical: 4),
                //                   child: Row(
                //                     children: [
                //                       Text(
                //                         'Fresh Toast With Barries',
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                             color: Colors.black,
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.w400),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Icons.star,
                //                       color: Color(ColorsConst.mainColor),
                //                     ),
                //                     Icon(
                //                       Icons.star,
                //                       color: Color(ColorsConst.mainColor),
                //                     ),
                //                     Icon(
                //                       Icons.star,
                //                       color: Color(ColorsConst.mainColor),
                //                     ),
                //                     Icon(
                //                       Icons.star,
                //                       color: Color(ColorsConst.mainColor),
                //                     )
                //                   ],
                //                 ),
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.symmetric(vertical: 8),
                //                   child: Row(
                //                     children: [
                //                       Text(
                //                         '120 Calories',
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                             color: Color(ColorsConst.mainColor),
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.w400),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Icons.access_time,
                //                       size: 18,
                //                       color: Colors.grey,
                //                     ),
                //                     const SizedBox(
                //                       width: 4,
                //                     ),
                //                     Text(
                //                       '10 mins',
                //                       style: TextStyle(color: Colors.grey),
                //                     )
                //                   ],
                //                 ),
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Icons.access_time,
                //                       size: 18,
                //                       color: Colors.grey,
                //                     ),
                //                     const SizedBox(
                //                       width: 4,
                //                     ),
                //                     Text(
                //                       '1 serving',
                //                       style: TextStyle(color: Colors.grey),
                //                     )
                //                   ],
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       )),
                // ),

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
