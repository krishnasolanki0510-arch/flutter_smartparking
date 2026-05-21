import 'package:flutter/material.dart';

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
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    // ORIGINAL LIST (NOT COPY)
    List<Map<String, dynamic>> selectedSlots = [];

    if (selectedCity != null) {
      selectedSlots = widget.data[selectedCity] ?? [];
    }

    int availableCount = selectedSlots
        .where((slot) => slot["available"] == true)
        .length;

    int reservedCount = selectedSlots
        .where((slot) => slot["available"] == false)
        .length;

    return Padding(
      padding: const EdgeInsets.all(15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          DropdownButton<String>(
            value: selectedCity,

            hint: const Text("Choose City"),

            isExpanded: true,

            items: widget.data.keys.map<DropdownMenuItem<String>>((city) {
              return DropdownMenuItem<String>(value: city, child: Text(city));
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
                        value: !slot["available"],
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            // TOGGLE STATUS
                            slot["available"] = !value!;
                          });
                          widget.refreshList();
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
                            widget.data[selectedCity]?.removeAt(index);
                          });
                          widget.refreshList();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Slot Deleted")),
                          );
                        },

                        icon: const Icon(Icons.delete, color: Colors.red),
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
          ] else
            const Expanded(
              child: Center(
                child: Text(
                  "Please choose a city to see parking spaces.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 20, 20),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
