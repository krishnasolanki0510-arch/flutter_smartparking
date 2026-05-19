import 'package:flutter/material.dart';

class Parkingscreen extends StatefulWidget {

  final List data;

  final Function refreshList;

  const Parkingscreen({
    super.key, required this.data,required this.refreshList,
  });

  @override
  State<Parkingscreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<Parkingscreen> {

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

    List<Map<String, dynamic>> selectedSlots = selectedCity != null
        ? parkingData[selectedCity]!
        : [];

    int availableCount = selectedSlots
        .where((slot) => slot["available"] == true)
        .length;

    int reservedCount = selectedSlots
        .where((slot) => slot["available"] == false)
        .length;

    return Scaffold(

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 40),

            Container(

              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),

              decoration: BoxDecoration(

                color: Colors.blue,

                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text(

                    "Smart Parking System",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Container(

                    decoration: BoxDecoration(

                      color: Colors.white.withOpacity(0.2),

                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: IconButton(

                      onPressed: () {},

                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(

              value: selectedCity,

              hint: const Text("Choose City"),

              isExpanded: true,

              items: parkingData.keys.map((city) {

                return DropdownMenuItem(
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

            if (selectedCity != null)

              Center(

                child: Column(

                  children: [

                    Text(

                      "Total Slots",

                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(

                      "${selectedSlots.length}",

                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 15),

            Expanded(

              child: ListView.builder(

                itemCount: selectedSlots.length,

                itemBuilder: (context, index) {

                  var slot = selectedSlots[index];

                  return Card(

                    elevation: 3,

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: CheckboxListTile(

                      value: !slot["available"],

                      onChanged: slot["available"] == false
                          ? null
                          : (value) {

                              setState(() {

                                slot["available"] = !value!;

                              });
                            },

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
                      ),

                      activeColor: Colors.red,

                      tileColor: slot["available"]
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  );
                },
              ),
            ),

            if (selectedCity != null)

              Center(

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Container(

                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(

                        color: Colors.green.shade100,

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Column(

                        children: [

                          const Text(

                            "Available",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(

                            "$availableCount",

                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    Container(

                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(

                        color: Colors.red.shade100,

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Column(

                        children: [

                          const Text(

                            "Reserved",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(

                            "$reservedCount",

                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}