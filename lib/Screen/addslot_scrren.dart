import 'package:flutter/material.dart';

class AddSlotScreen extends StatefulWidget {
  final List<String> cities;

  final Function(Map) onSave;

  const AddSlotScreen({super.key, required this.cities, required this.onSave});

  @override
  State<AddSlotScreen> createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  TextEditingController slotController = TextEditingController();
  String? selectedCity;
  List<String> slots = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Add New Slots",

            style: TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 20),

          // CITY DROPDOWN
          DropdownButton<String>(
            value: selectedCity,

            hint:Text("Choose City"),

            isExpanded: true,

            items: ["Vadodara", "Ahmedabad", "Surat", ...widget.cities]
                .toSet()
                .map((city) {
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

          const SizedBox(height: 20),

          // TEXTFIELD + ADD BUTTON
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: slotController,

                  decoration: InputDecoration(
                    hintText: "Enter Slot",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  if (selectedCity == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a city first"),
                      ),
                    );

                    return;
                  }

                  if (slotController.text.isNotEmpty) {
                    setState(() {
                      slots.add(slotController.text);
                    });

                    slotController.clear();
                  }
                },

                child: const Text("Add"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // SLOT LIST
          Expanded(
            child: ListView.builder(
              itemCount: slots.length,

              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(slots[index]),

                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          slots.removeAt(index);
                        });
                      },

                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),

          // SAVE BUTTON
          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                if (selectedCity == null || slots.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select city and add slots"),
                    ),
                  );

                  return;
                }

                widget.onSave({"city": selectedCity, "slots": slots});
              },

              child: const Text("Save Slots"),
            ),
          ),
        ],
      ),
    );
  }
}