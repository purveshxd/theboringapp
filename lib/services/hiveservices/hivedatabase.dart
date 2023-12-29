import 'package:hive_flutter/adapters.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';

class HiveDb {
  // Data Structure
  // final userData = {
  //   "username": "Purvesh",
  //   "savedActivities": [
  //     BoredModel(
  //       activity: "default activity",
  //       type: "education",
  //       participants: 1,
  //       price: .1,
  //       link: "link default",
  //       key: "4651651",
  //       accessibility: 5,
  //     ),
  //     BoredModel(
  //       activity: "default activity number 2",
  //       type: "education",
  //       participants: 1,
  //       price: .1,
  //       link: "link default",
  //       key: "4651651",
  //       accessibility: 5,
  //     ),
  //   ]
  // };

  List savedActivities = [];
  String username = "";
  final dataBox = Hive.box('savedActivitiesBox');

  void initialData() {
    savedActivities = [
      boredModelToJson(
        BoredModel(
          activity: "This is the default activity",
          type: "education",
          participants: 1,
          price: .1,
          link: "link default",
          key: "4651651",
          accessibility: 5,
        ),
      ),
    ];
  }

  void putUserData(String username) async {
    await dataBox.put("userdata", username);
  }

  void deleteActivity(key) {
    savedActivities.removeWhere((element) => element['key'] == key);
    updateActivitiesData();
  }

  String loadUserData() {
    username = dataBox.get('userdata');
    return username;
  }

  loadActivitiesData() {
    List activity = dataBox.get("savedActivities");
    savedActivities.addAll(activity);
  }

  void updateActivitiesData() {
    dataBox.put("savedActivities", savedActivities);
  }

  List isSaved() {
    List savedKeys = [];
    for (var element in savedActivities) {
      savedKeys.add(boredModelFromJson(element).key);
    }

    return savedKeys;
  }
}
