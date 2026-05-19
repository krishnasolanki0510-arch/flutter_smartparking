import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const ParkingScreen(),
    );
  }
}

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

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

  // Controllers
  final TextEditingController cityController = TextEditingController();

  final TextEditingController slotController = TextEditingController();

  void addCity() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Add City"),

          content: TextField(
            controller: cityController,

            decoration: const InputDecoration(hintText: "Enter City Name"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                if (cityController.text.isNotEmpty) {
                  setState(() {
                    parkingData[cityController.text] = [];
                  });

                  cityController.clear();

                  Navigator.pop(context);
                }
              },

              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void addSlot() {
    if (selectedCity == null) return;

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Add Parking Slot"),

          content: TextField(
            controller: slotController,

            decoration: const InputDecoration(hintText: "Enter Slot Name"),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                if (slotController.text.isNotEmpty) {
                  setState(() {
                    parkingData[selectedCity]!.add({
                      "slot": slotController.text,
                      "available": true,
                    });
                  });

                  slotController.clear();

                  Navigator.pop(context);
                }
              },

              child: const Text("Add Slot"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Selected Slots
    List<Map<String, dynamic>> selectedSlots = selectedCity != null
        ? parkingData[selectedCity]!
        : [];

    // Available Count
    int availableCount = selectedSlots
        .where((slot) => slot["available"] == true)
        .length;

    // Reserved Count
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

            // Custom AppBar Design
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),

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

                  IconButton(
                    onPressed: addCity,

          icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown
            DropdownButton<String>(
              value: selectedCity,

              hint: const Text("Choose City"),

              isExpanded: true,

              items: parkingData.keys.map((city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
             onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),
const SizedBox(height: 20),

            // Center Total Slots
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

            // Slot List
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
                      // true = reserved
                      value: !slot["available"],

                      onChanged: (value) {
                        setState(() {
                          slot["available"] = !value!;
                        });
                      },

                      title: Text(
                        "Parking Slot ${slot["slot"]}",

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      subtitle: Text(
                        slot["available"] ? "Available" : "Reserved",
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

            // Bottom Counts
            if (selectedCity != null)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    // Available Box
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

                    // Reserved Box
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
