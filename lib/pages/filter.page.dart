import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var selectedUserValue = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Wrap(
            // space between chips
            spacing: 10,
            // list of chips
            children: [
              InkWell(
                onTap: () {
                  selectedUserValue['type'] = "breakfast";
                  setState(() {});
                },
                child: Chip(
                  label: Text('Breakfast'),
                  backgroundColor: selectedUserValue['type'] == "breakfast"
                      ? Colors.orange
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
              ),
              InkWell(
                onTap: () {
                  selectedUserValue['type'] = "launch";
                  setState(() {});
                },
                child: Chip(
                  label: Text('Launch'),
                  backgroundColor: selectedUserValue['type'] == "launch"
                      ? Colors.orange
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
              ),
              InkWell(
                onTap: () {
                  selectedUserValue['type'] = "dinner";
                  setState(() {});
                },
                child: Chip(
                  label: Text('Dinner'),
                  backgroundColor: selectedUserValue['type'] == "dinner"
                      ? Colors.orange
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
              ),
            ]),
      ),
    );
  }
}
