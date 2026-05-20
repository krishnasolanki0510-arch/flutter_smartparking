import 'package:flutter/material.dart';
import 'Listing_screen.dart';
import 'addcity_screen.dart';
import 'addslot_scrren.dart';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {

  // PARKING DATA
  Map<String, List<Map<String, dynamic>>> data = {};

  List<Map<String, dynamic>> studentData = [ //parent data to child
{
      "age": 19,
    },
  ];

  String currentScreen = "/home";
  Widget getScreen() {

    switch (currentScreen) {

      // ADD CITY SCREEN
      case "/s1":
      return AddCityScreen(
        onSave: (cityName) {
            setState(() {
            if (cityName.isNotEmpty) {
              data[cityName] = [];
              }
              currentScreen = "/home";
            });
          },
        );

      // ADD SLOT SCREEN
      case "/s2":
       return AddSlotScreen(

          cities: data.keys.toList(),
          onSave: (result) {
            String city = result["city"];

            List<String> newSlots =
                List<String>.from(result["slots"]);

            setState(() {

              if (!data.containsKey(city)) {

                data[city] = [];
              }

              for (var slot in newSlots) {

                data[city]!.add({

                  "slot": slot,

                  "available": true,
                });
              }

              currentScreen = "/home";
            });
          },
        );

      // HOME SCREEN
      default:

        return ParkingScreen(
          data: data,
          studentData: studentData,
          refreshList: (route) {

            setState(() {

              currentScreen = route;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("AutoSlot"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        centerTitle: true,

        leading: currentScreen != "/home"

            ? IconButton(

                onPressed: () {

                  setState(() {

                    currentScreen = "/home";
                  });
                },

                icon: const Icon(Icons.arrow_back),
              )

            : null,

        actions: [

          IconButton(

            onPressed: () {

              setState(() {

                currentScreen = "/s1";
              });
            },

            icon: const Icon(Icons.location_city),
          ),

          IconButton(

            onPressed: () {

              setState(() {

                currentScreen = "/s2";
              });
            },

            icon: const Icon(Icons.add_box),
          ),
        ],
      ),

      body: getScreen(),
    );
  }
}