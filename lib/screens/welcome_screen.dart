import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:theboringapp/screens/homepage.dart';
import 'package:theboringapp/services/hiveservices/hivedatabase.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    HiveDb().putUserData(textController.text);
                    // HiveDb().username = textController.text;
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ));
                  // HiveDb().updateActivitiesData();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
