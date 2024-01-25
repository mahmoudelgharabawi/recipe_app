import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class RecipeWidgeteX extends StatefulWidget {
  const RecipeWidgeteX({super.key});

  @override
  State<RecipeWidgeteX> createState() => _RecipeWidgeteXState();
}

class _RecipeWidgeteXState extends State<RecipeWidgeteX> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
          width: 240,
          decoration: BoxDecoration(
              color: Color(
                ColorsConst.containerBackgroundColor,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
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
                          style:
                              TextStyle(color: Color(0xff1F95B3), fontSize: 13),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
