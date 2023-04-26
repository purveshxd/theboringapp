import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:theboringapp/constants/constants.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';
import 'package:theboringapp/widgets/text_field_custom.dart';

class SavedActivitiesPage extends StatefulWidget {
  final List allSavedList;
  final Function clearAllActivities;
  const SavedActivitiesPage(
      {super.key,
      required this.allSavedList,
      required this.clearAllActivities});

  @override
  State<SavedActivitiesPage> createState() => _SavedActivitiesPageState();
}

class _SavedActivitiesPageState extends State<SavedActivitiesPage> {
  bool isSelected() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Saved Activities"),

        
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    widget.clearAllActivities();
                  });
                },
                child: const Text("Clear all")),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Expanded(
            child: Row(
              children: [],
            ),
          ),
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemCount: widget.allSavedList.length,
              itemBuilder: (context, index) {
                final allSavedListReverse = widget.allSavedList.reversed;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: StyleContainerCustom(
                      '{\n"activity": "${boredModelFromJson(allSavedListReverse.elementAt(index)).activity}",\n"type": "${boredModelFromJson(allSavedListReverse.elementAt(index)).type}",\n"key": "${boredModelFromJson(allSavedListReverse.elementAt(index)).key}"\n'
                      '"link":"${boredModelFromJson(allSavedListReverse.elementAt(index)).link}"\n}'),
                  // '\n"type": "${boredModelFromJson(reverseList.elementAt(index)).type}"\n}'),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
