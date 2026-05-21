import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Listing_screen.dart';
import 'addcity_screen.dart';
import 'addslot_scrren.dart';
import 'dart:convert';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();}

class _FragmentHolderState extends State<FragmentHolder> {

  // Parking data
  Map<String, List<Map<String, dynamic>>> data = {"Vadodara": [

      {"slot": "A1", "available": true},
      {"slot": "A2", "available": false},
      {"slot": "A3", "available": true},
      {"slot": "A4", "available": false},
      {"slot": "A5", "available": true},
      {"slot": "A6", "available": true},
      {"slot": "A7", "available": true},
      {"slot": "A8", "available": false},
    ],

    "Ahmedabad": [

      {"slot": "B1", "available": true},
      {"slot": "B2", "available": true},
      {"slot": "B3", "available": false},
      {"slot": "B4", "available": true},
      {"slot": "B5", "available": false},
      {"slot": "B6", "available": true},
      {"slot": "B7", "available": false},
      {"slot": "B8", "available": true},
    ],

    "Surat": [
      {"slot": "C1", "available": false},
      {"slot": "C2", "available": true},
      {"slot": "C3", "available": true},
      {"slot": "C4", "available": false},
      {"slot": "C5", "available": true},
      {"slot": "C6", "available": false},
      {"slot": "B6", "available": true},
      {"slot": "B6", "available": false},
    ],};
  @override
  void initState() {
    super.initState();
    prepareList();
  }
 Future<void> saveList() async {

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> finalData = {
      "newData": data,
    };
    String jsonString = jsonEncode(finalData);
    await prefs.setString("parkingdata",jsonString, );
  }
  catch(e) {

  }
}
   

  Future<void> prepareList() async {

  try {

    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? jsonString =
        prefs.getString("parkingdata");

    if (jsonString != null) {

      Map<String, dynamic> decodedData =
          jsonDecode(jsonString);

      Map<String, List<Map<String, dynamic>>> loadedData =
          fromJson(
            decodedData["newData"] ?? {},
          );

      // REPLACE OLD DATA
      data = loadedData;

      setState(() {});
    }
  }

  catch(e) {

    print(e);

  }
}
  Map<String, List<Map<String, dynamic>>>fromJson( Map<String, dynamic> json, ) {
 return json.map(
      (key, value) => MapEntry(
        key, List<Map<String, dynamic>>.from(value),
    ),
    );
  }

  // Parent data
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("AutoSlot"),
        backgroundColor:Colors.blue,
        foregroundColor:Colors.white,
        centerTitle:true,
        actions: [

    IconButton(
    onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title:Text("AutoSlot"),
                     
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
                          });saveList();
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
          onPressed: () {Navigator.push( context,
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
                  List<String> newSlots =List<String>.from(result["slots"]);

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
                          });saveList();

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
      data: data,refreshList: () {
        saveList();
      },
      ),
      ),
      );
  }
}