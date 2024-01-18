import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/page_view.page.dart';
import 'package:recipe_app/provider/app_auth.provider.dart';
import 'package:recipe_app/services/meal.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/navigation.utils.dart';
import 'package:recipe_app/utils/numbers.dart';
import 'package:recipe_app/widgets/ads_widget.dart';
import 'package:recipe_app/widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  CarouselController carouselControllerEx = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
          child: Icon(Icons.menu),
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
              Card(
                elevation: 2,
                child: Container(
                    width: 240,
                    decoration: BoxDecoration(
                        color: Color(
                          ColorsConst.containerBackgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                              Transform.translate(
                                offset: Offset(20, 0),
                                child: Image.asset(
                                  'assets/images/frensh_toast.png',
                                  height: 140,
                                  width: 200,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Breakfast',
                                    style: TextStyle(
                                        color: Color(0xff1F95B3), fontSize: 13),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Fresh Toast With Barries',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(ColorsConst.mainColor),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(ColorsConst.mainColor),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(ColorsConst.mainColor),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(ColorsConst.mainColor),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      '120 Calories',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(ColorsConst.mainColor),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '10 mins',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '1 serving',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
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

                    await FirebaseFirestore.instance
                        .collection('ads')
                        .doc("custiom id")
                        .set({
                      "title": "Less Carbs Meals",
                      "image":
                          "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.wallpaperflare.com%2Fstatic%2F778%2F966%2F360%2Fgreek-cooking-recipe-lettuce-wallpaper.jpg&f=1&nofb=1&ipt=d368b40582b66339031ebdc23aaaad0d225155af57a897834200c15d0bccd2d0&ipo=images"
                    });

                    OverlayLoadingProgress.stop();
                  },
                  child: Text('add')),
            ],
          ),
        ),
      ),
    );
  }
}
