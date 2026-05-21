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

  Map<String, List<Map<String, dynamic>>> data = {};

  void refreshList(dynamic value) async {

    // Add City Screen
    if (value == "/s1") {

      final result = await Navigator.push(

        context,

        MaterialPageRoute(

          builder: (context) => const AddCityScreen(),
        ),
      );

      if (result != null) {

        setState(() {

          data[result] = [];

        });
      }
    }

    // Add Slot Screen
    else if (value == "/s2") {

      final result = await Navigator.push(

        context,

        MaterialPageRoute(

          builder: (context) => AddSlotScreen(
            cities: data.keys.toList(),
          ),
        ),
      );

      if (result != null) {

        String city = result["city"];

        List<String> slots = List<String>.from(result["slots"]);

        setState(() {

          if (!data.containsKey(city)) {

            data[city] = [];
          }

          for (var slot in slots) {

            data[city]!.add({

              "slot": slot,
              "available": true,
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return ParkingScreen(

      data: data,

      refreshList: refreshList,
    );
  }
}