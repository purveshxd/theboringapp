// To parse this JSON data, do
//
//     final boredModel = boredModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BoredModel boredModelFromJson(String str) =>
    BoredModel.fromJson(json.decode(str));

String boredModelToJson(BoredModel data) => json.encode(data.toJson());

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

  String activity;
  String type;
  int participants;
  double price;
  String link;
  String key;
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
        accessibility: accessibility
        ,
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
