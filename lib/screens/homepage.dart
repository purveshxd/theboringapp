import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theboringapp/constants/constants.dart';
import 'package:theboringapp/screens/savedActivities.dart';
import 'package:theboringapp/screens/welcome_Screen.dart';
import 'package:theboringapp/services/apiservices/api_service.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';
import 'package:theboringapp/services/hiveservices/hivedatabase.dart';
import 'package:theboringapp/services/providers/api_providers.dart';
// import 'package:theboringapp/widgets/nav_bar.dart';
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
    if (_mybox.get('savedActivitiesBox') == null ||
        _mybox.get('userdata') == null) {
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
      backgroundColor: Colors.grey.shade300,
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
                    'Hi,\n'
                    // TODO - username here
                    '${hiveDb.loadUserData()}',
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          hiveDb.username = '';
                          hiveDb.putUserData('');
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ));
                        // hiveDb.updateActivitiesData();
                      },
                      child: const Text("Delete User"))
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Some random activity for you",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: ApiService().getRandomActivity(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        StyleContainerCustom(
                            '{\n"activity": "${snapshot.data?.activity}",\n"type": "${snapshot.data?.type}",\n"key": "${snapshot.data?.key}"\n'
                            '"link":"${snapshot.data!.link.isEmpty ? "hey" : snapshot.data?.link}"\n}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                    return StyleContainerCustom(snapshot.error.toString());
                  } else {
                    return const StyleContainerCustom("",
                        widget: CircularProgressIndicator());
                  }
                },
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Previously saved activities",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavedActivitiesPage(
                                  clearAllActivities: deleteAllActivities,
                                  allSavedList: hiveDb.savedActivities),
                            ));
                      },
                      child: const Text("More"))
                ],
              ),
              Expanded(
                  child: hiveDb.savedActivities == null
                      ? const Text("No saved Activities")
                      : ListView.builder(
                          // reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: hiveDb.savedActivities.length < 5
                              ? hiveDb.savedActivities.length
                              : 5,

                          itemBuilder: (context, index) {
                            final reverseList = hiveDb.savedActivities.reversed;

                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: StyleContainerCustom(
                                    '{\n"activity": "${boredModelFromJson(reverseList.elementAt(index)).activity}"\n}')
                                // '\n"type": "${boredModelFromJson(reverseList.elementAt(index)).type}"\n}'),
                                );
                          },
                        ))
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
