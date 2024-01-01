import 'package:flutter/material.dart';


class WidgetScrollable extends StatelessWidget {

  final List<Widget>? widgets;

  final bool isColumn;

  final ScrollController? controller;

  final MainAxisAlignment? columnMainAxisAlignment;

  final MainAxisAlignment? rowMainAxisAlignment;

  const WidgetScrollable({Key? key,

    this.widgets,

    this.controller,

    this.isColumn = false,

    this.columnMainAxisAlignment,

    this.rowMainAxisAlignment})

      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(

          physics: const AlwaysScrollableScrollPhysics(),

          controller: controller ?? ScrollController(),

          scrollDirection: isColumn ? Axis.vertical : Axis.horizontal,

          child: ConstrainedBox(

            constraints: isColumn

                ? BoxConstraints(minHeight: constraints.maxHeight)

                : BoxConstraints(

              minWidth: constraints.maxWidth,

            ),

            child: isColumn

                ? Column(

                mainAxisAlignment: columnMainAxisAlignment ??

                    MainAxisAlignment.spaceEvenly,

                children: widgets ?? [])

                : Row(

              mainAxisAlignment:

              rowMainAxisAlignment ?? MainAxisAlignment.spaceBetween,

              children: widgets ?? [],

            ),

          ),

        );
      },

    );
  }

}

