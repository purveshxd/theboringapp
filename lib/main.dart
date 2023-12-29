import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:theboringapp/screens/homepage.dart';
import 'package:theboringapp/screens/initial_demo.dart';

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
    final dataBox = Hive.box('savedActivitiesBox');

    return MaterialApp(
        title: 'theboringapp',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.amberAccent),
        home: dataBox.get('savedActivities') == null
            ? const InitialDemo()
            : const Homepage()
        // home: const Homepage(),
        );
  }
}
