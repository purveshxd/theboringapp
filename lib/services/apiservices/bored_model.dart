// To parse this JSON data, do
//
//     final boredModel = boredModelFromJson(jsonString);

import 'package:hive_flutter/adapters.dart';
import 'dart:convert';

BoredModel boredModelFromJson(String str) =>
    BoredModel.fromJson(json.decode(str));

String boredModelToJson(BoredModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class BoredModel {
  BoredModel({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });
  @HiveField(0)
  String activity;
  @HiveField(1)
  String type;
  @HiveField(2)
  int participants;
  @HiveField(3)
  double price;
  @HiveField(4)
  String link;
  @HiveField(5)
  String key;
  @HiveField(6)
  double accessibility;

  BoredModel copyWith({
    required String activity,
    required String type,
    required int participants,
    required double price,
    required String link,
    required String key,
    required double accessibility,
  }) =>
      BoredModel(
        activity: activity,
        type: type,
        participants: participants,
        price: price,
        link: link,
        key: key,
        accessibility: accessibility,
      );

  factory BoredModel.fromJson(Map<String, dynamic> json) => BoredModel(
        activity: json["activity"],
        type: json["type"],
        participants: json["participants"],
        price: json["price"]?.toDouble(),
        link: json["link"],
        key: json["key"],
        accessibility: json["accessibility"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "price": price,
        "link": link,
        "key": key,
        "accessibility": accessibility,
      };
}
