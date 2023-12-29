import 'package:flutter/material.dart';
import 'package:theboringapp/constants/constants.dart';
import 'package:theboringapp/screens/welcome_screen.dart';
import 'package:theboringapp/widgets/bullet_list.dart';

class InitialDemo extends StatelessWidget {
  const InitialDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: backgroundColor,
      //   centerTitle: true,
      //   title: const Text(
      //     "the_boring_app",
      //     style: TextStyle(
      //       color: mainTextColor,
      //       fontFamily: 'Monospace',
      //       fontSize: 27,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "the_boring_app",
                  style: TextStyle(
                    color: mainTextColor,
                    fontFamily: 'Monospace',
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: const BulletList([
                    "Get random activities when you are bored",
                    "Save activities you liked and delete them as you complete them.",
                    "Save activities you liked and delete them as you complete them."
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.extended(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        )),
                    label: const Row(
                      children: [
                        Text("Get Started"),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () => Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const WelcomeScreen(),
      //         )),
      //     label: const Text("Get Started")),
    );
  }
}
//  Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // CircleAvatar(
//                     //   backgroundColor: containerColor,
//                     //   radius: MediaQuery.of(context).size.width / 5,
//                     // ),
//                     Container(
//                       width: MediaQuery.of(context).size.width / 2,
//                       height: MediaQuery.of(context).size.width / 2,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         backgroundBlendMode: BlendMode.lighten,
//                         gradient: RadialGradient(
//                           center: Alignment.center,
//                           focal: Alignment.center,
//                           colors: [
//                             mainTextColor.withOpacity(.7),
//                             backgroundColor.withOpacity(.1),
//                             // containerColor,
//                           ],
//                         ),
//                       ),
//                     ),
//                     const RotationTransition(
//                       alignment: Alignment.center,
//                       turns: AlwaysStoppedAnimation(-15 / 360),
//                       child: Text(
//                         "the_boring_app",
//                         style: TextStyle(
//                           color: mainTextColor,
//                           fontFamily: 'Monospace',
//                           fontSize: 27,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),