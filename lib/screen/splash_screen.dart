import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/a7395e40-2054-4147-8314-728e940a8063.jpg"),
      fit: BoxFit.cover,
    ),
  ),
  child: Column(
  children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Text(

            "v1.0",

            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
         ),
         ),
        ],
      ),
      SizedBox(height: 150),
      Image.asset(
        "assets/park.png",height: 110,width: 110,
      ),
      SizedBox(height: 20),
      Text( "AutoSlot", style: TextStyle(
        fontSize: 35,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
      SizedBox(height: 30),
      CircularProgressIndicator(
      color: Colors.white,
      ),
      SizedBox(height: 20),
      Text(
        "Your Parking Solution",style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    ],
  ),
),
);
  }
}