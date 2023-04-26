import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:theboringapp/screens/homepage.dart';
import 'package:theboringapp/screens/welcome_screen.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';
import 'package:theboringapp/services/hiveservices/hivedatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("savedActivitiesBox");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'theboringapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: const WelcomeScreen(),
      home: HiveDb().dataBox.get('userdata') == ''
          ? const WelcomeScreen()
          : const Homepage(),
    );
  }
}
