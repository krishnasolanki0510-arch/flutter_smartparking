import 'package:flutter/material.dart';
import 'addcity_screen.dart';
import 'addslot_scrren.dart';

class ParkingScreen extends StatefulWidget {
  final Map data;
  final List<Map<String, dynamic>> studentData;
  final Function refreshList;

  const ParkingScreen({
    super.key,
    required this.data,
    required this.studentData,
    required this.refreshList,
  });

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {

  Map<String, List<Map<String, dynamic>>> parkingData = {

    "Vadodara": [

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
    ],
  };

  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    //used for navigation
    List selectedSlots = [];

    if (selectedCity != null) {
      selectedSlots = [
        ...(parkingData[selectedCity] ?? []),

        ...(widget.data[selectedCity] ?? []),
      ];
    }

    int availableCount = selectedSlots
        .where((slot) => slot["available"] == true)
        .length;
    int reservedCount = selectedSlots
        .where(
          (slot) => slot["available"] == false,
        ) //Sirf reserved slots filter honge
        .length;

    return Padding(
      padding: EdgeInsets.all(15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          DropdownButton<String>(
            value: selectedCity,

            hint: Text("Choose City"),

            isExpanded: true,

            items: {...parkingData.keys, ...widget.data.keys}
                .map<DropdownMenuItem<String>>((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                })
                .toList(),

            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),

          SizedBox(height: 20),
          Text("Age: ${widget.studentData[0]["age"]}"),

          SizedBox(height: 20),

          if (selectedCity != null) ...[
            Card(
              color: Colors.blue.shade50,

              child: Padding(
                padding: EdgeInsets.all(15.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Slots",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "${selectedSlots.length}",

                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: selectedSlots.length,

                itemBuilder: (context, index) {
                  var slot = selectedSlots[index];

                  bool isReserved = !slot["available"];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: ListTile(
                      tileColor: slot["available"]
                          ? Colors.green.shade50
                          : Colors.red.shade50,

                      leading: Checkbox(
                        value: isReserved,
                        activeColor: Colors.red,

                        onChanged: isReserved
                            ? null
                            : (value) {
                                setState(() {
                                  slot["available"] = !value!;
                                });
                              },
                      ),

                      title: Text(
                        "Parking Slot ${slot["slot"]}",

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(
                        slot["available"] ? "Available" : "Already Reserved",

                        style: TextStyle(
                          color: slot["available"]
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                      ),

                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            String slotName = slot["slot"];

                            parkingData[selectedCity]?.removeWhere(
                              (item) => item["slot"] == slotName,
                            );

                            widget.data[selectedCity]?.removeWhere(
                              (item) => item["slot"] == slotName,
                            );
                          });
                        },

                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 15),

            Card(
              color: Colors.grey.shade100,

              child: Padding(
                padding: EdgeInsets.all(15.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Column(
                      children: [
                        Text(
                          "Available",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "$availableCount",

                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "Reserved",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "$reservedCount",

                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ] else
            Expanded(
              child: Center(
                child: Text(
                  "Please choose a city to see parking spaces.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}