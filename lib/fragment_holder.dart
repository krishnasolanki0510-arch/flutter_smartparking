import 'package:flutter/material.dart';
import 'Screen/Listing_screen.dart';
import 'addcity_screen.dart';
import 'addslot_screen.dart';

class FragmentHolder extends StatefulWidget {
const FragmentHolder({super.key});
@override
State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  // Parking data
  Map<String, List<Map<String, dynamic>>> data = {};

  // Parent data
  final List<Map<String, dynamic>> studentData = [
    {"age": 19},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AutoSlot"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("AutoSlot"),

                      backgroundColor: Colors.blue,

                      foregroundColor: Colors.white,
                      centerTitle: true,
                    ),

                    body: Container(
                      padding: const EdgeInsets.all(10),
                      child: AddCityScreen(
                        onSave: (cityName) {
                          setState(() {
                            if (cityName.isNotEmpty) {
                              data[cityName] = [];
                            }
                          });

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },

            icon: const Icon(Icons.location_city),
          ),
          // ADD SLOT BUTTON
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text("AutoSlot"),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.all(10),
                      child: AddSlotScreen(
                        cities: data.keys.toList(),
                        onSave: (result) {
                          String city = result["city"];
                          List<String> newSlots = List<String>.from(
                            result["slots"],
                          );

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
                          });

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },

            icon: const Icon(Icons.add_box),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ParkingScreen(
          data: data,
          studentData: studentData,
          refreshList: (route) {},
        ),
      ),
    );
  }
}
