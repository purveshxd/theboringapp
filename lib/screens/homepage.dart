import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theboringapp/constants/constants.dart';
import 'package:theboringapp/screens/saved_activities.dart';
import 'package:theboringapp/services/apiservices/api_service.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';
import 'package:theboringapp/services/hiveservices/hivedatabase.dart';
import 'package:theboringapp/widgets/text_field_custom.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HiveDb hiveDb = HiveDb();
  final _mybox = Hive.box('savedActivitiesBox');
  @override
  void initState() {
    if (_mybox.get("savedActivities") == null) {
      hiveDb.initialData();
    } else {
      hiveDb.loadActivitiesData();
    }

    super.initState();
  }

  bool isSaved(String currentActivity) {
    if (hiveDb.savedActivities.contains(currentActivity)) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAllActivities() {
    setState(() {
      hiveDb.savedActivities.clear();
    });
    hiveDb.updateActivitiesData();
  }

  final randomActivity = ApiService().getRandomActivity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi,${hiveDb.loadUserData()}',
                    style: const TextStyle(
                        fontFamily: 'Monospace',
                        color: mainTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Some random activity for you",
                style: TextStyle(
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: ApiService().getRandomActivity(),
                builder: (context, snapshot) {
                  // final temp = snapshot.data!.link;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        StyleContainerCustom(
                          '{\n'
                          '\t"activity": "${snapshot.data?.activity}",\n'
                          '\t"type": "${snapshot.data?.type}",\n'
                          '\t"key": "${snapshot.data?.key}",\n'
                          '\t"link":"${snapshot.data!.link}"\n'
                          '}',
                          isSaved: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                isSelected: isSaved(snapshot.data!.key),
                                onPressed: () {
                                  setState(() {
                                    final data = snapshot.data;
                                    hiveDb.savedActivities
                                        .add(boredModelToJson(data!));
                                  });
                                  hiveDb.updateActivitiesData();
                                },
                                icon: const Icon(Icons.bookmark_rounded),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return StyleContainerCustom(
                      snapshot.error.toString(),
                      isSaved: false,
                    );
                  } else {
                    return const StyleContainerCustom(
                      "",
                      widget: CircularProgressIndicator(),
                      isSaved: false,
                    );
                  }
                },
              ),
              const Divider(),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Saved Activities",
                          style: TextStyle(
                              color: subTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedActivitiesPage(
                                    allSavedList: hiveDb.savedActivities,
                                    clearAllActivities: deleteAllActivities,
                                  ),
                                ),
                              );
                            },
                            child: const Text("More"))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: hiveDb.savedActivities.length,
                          itemBuilder: (context, index) {
                            final List reversedList =
                                hiveDb.savedActivities.reversed.toList();

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: StyleContainerCustom(
                                '${index + 1}. ${reversedList[index].split(':')[1].toString().split(',')[0].toString()}',
                                isSaved: false,
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Random'),
        onPressed: () {
          setState(() {
            ApiService().getRandomActivity();
          });
          debugPrint(hiveDb.savedActivities.toString());
        },
        icon: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
