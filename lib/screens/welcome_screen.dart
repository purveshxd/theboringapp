import 'package:flutter/material.dart';
import 'package:theboringapp/constants/constants.dart';
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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi, Welcome to the_boring_app",
                style: TextStyle(
                    fontFamily: 'Monospace',
                    fontSize: 30,
                    color: mainTextColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "What should we call you",
                style: TextStyle(
                    color: subTextColor,
                    fontFamily: 'Monospace',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                controller: textController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            HiveDb().putUserData(textController.text.trim());
            // HiveDb().username = textController.text;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ));
          });
        },
        label: const Text('Submit'),
      ),
    );
  }
}
