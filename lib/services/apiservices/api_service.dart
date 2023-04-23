import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:theboringapp/services/apiservices/bored_model.dart';

class ApiService {
  final baseUrl = 'https://www.boredapi.com/api/';
  Future<BoredModel> getRandomActivity() async {
    final res = await http.get(Uri.parse('${baseUrl}activity'));
    debugPrint(res.body);
    return boredModelFromJson(res.body);
    // return res.body;
  }
}
