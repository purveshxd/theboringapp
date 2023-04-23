import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theboringapp/services/apiservices/api_service.dart';
import 'package:theboringapp/services/apiservices/bored_model.dart';
import 'package:theboringapp/services/providers/api_providers.dart';
import 'package:theboringapp/widgets/nav_bar.dart';
import 'package:theboringapp/widgets/text_field_custom.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final randomActivity = ApiService().getRandomActivity();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi,\n'
                // TODO - Username here
                'Purveshxd',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Text(
                "Some random activity for you",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: randomActivity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StyleContainerCustom(
                        '{\n"activity": "${snapshot.data?.activity}",\n"type": "${snapshot.data?.type}",\n"key": "${snapshot.data?.key}"\n},\n');
                  } else if (snapshot.hasError) {
                    return StyleContainerCustom(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Random'),
        onPressed: () {
          setState(() {
            randomActivity;
          });
        },
        icon: const Icon(Icons.refresh_rounded),
      ),
      bottomNavigationBar: const NavBarCustom(),
    );
  }
}
