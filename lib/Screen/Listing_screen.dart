import 'package:flutter/material.dart';
import 'addcity_screen.dart';
import 'addslot_scrren.dart';

class ParkingScreen extends StatefulWidget {

  final Map data;

  final Function refreshList;

  const ParkingScreen({
    super.key,
    required this.data,
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
    ],

    "Ahmedabad": [

      {"slot": "B1", "available": true},
      {"slot": "B2", "available": true},
      {"slot": "B3", "available": false},
      {"slot": "B4", "available": true},
      {"slot": "B5", "available": false},
      {"slot": "B6", "available": true},
    ],

    "Surat": [

      {"slot": "C1", "available": false},
      {"slot": "C2", "available": true},
      {"slot": "C3", "available": true},
      {"slot": "C4", "available": false},
      {"slot": "C5", "available": true},
      {"slot": "C6", "available": false},
    ],
  };

  String? selectedCity;

  @override
  Widget build(BuildContext context) {

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
        .where((slot) => slot["available"] == false)
        .length;

    return Scaffold(

      appBar: AppBar(

        title: const Text("Smart Parking System"),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        actions: [

          IconButton(

            onPressed: () {

              widget.refreshList("/s1");

            },

            icon: const Icon(Icons.location_city),

            tooltip: "Add City",
          ),

          IconButton(

            onPressed: () {

              widget.refreshList("/s2");

            },

            icon: const Icon(Icons.add_box),

            tooltip: "Add Slot",
          ),
        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            DropdownButton<String>(

  value: selectedCity,

  hint: const Text("Choose City"),

  isExpanded: true,
  items: {...parkingData.keys, ...widget.data.keys}
    .map<DropdownMenuItem<String>>((city) {

  return DropdownMenuItem<String>(

    value: city,

    child: Text(city),
  );

}).toList(),

  onChanged: (value) {

    setState(() {

      selectedCity = value;

    });
  },
),

            const SizedBox(height: 20),

            if (selectedCity != null) ...[

              Card(

                color: Colors.blue.shade50,

                child: Padding(

                  padding: const EdgeInsets.all(15.0),

                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Column(

                        children: [

                          const Text(

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

              const SizedBox(height: 15),

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

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(

                          slot["available"]
                              ? "Available"
                              : "Already Reserved",

                          style: TextStyle(

                            color: slot["available"]
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),

                        trailing: IconButton(

                          onPressed: () {

                            setState(() {

                              selectedSlots.removeAt(index);

                            });
                          },

                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              Card(

                color: Colors.grey.shade100,

                child: Padding(

                  padding: const EdgeInsets.all(15.0),

                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [

                      Column(

                        children: [

                          const Text(

                            "Available",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(

                            "$availableCount",

                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      Column(

                        children: [

                          const Text(

                            "Reserved",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(

                            "$reservedCount",

                            style: const TextStyle(
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
            ]

            else

              const Expanded(

                child: Center(

                  child: Text(

                    "Please choose a city to see parking spaces.",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}