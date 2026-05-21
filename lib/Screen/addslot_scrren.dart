import 'package:flutter/material.dart';

class AddSlotScreen extends StatefulWidget {

  final List<String> cities;

  const AddSlotScreen({
    super.key,
    required this.cities,
  });

  @override
  State<AddSlotScreen> createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {

  TextEditingController slotController = TextEditingController();

  String? selectedCity;

  List<String> slots = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Add Slot"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            // Dropdown

            DropdownButton<String>(

              value: selectedCity,

              hint: const Text("Choose City"),

              isExpanded: true,

              items: [

                "Vadodara",
                "Ahmedabad",
                "Surat",

                ...widget.cities,

              ].toSet().map((city) {

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

            // TextField + Button

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

                          content: Text(
                            "Please select a city first",
                          ),
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

            // Slot List

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

            // Save Button

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  if (selectedCity == null || slots.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Please select city and add slots",
                        ),
                      ),
                    );

                    return;
                  }

                  Navigator.pop(

                    context,

                    {
                      "city": selectedCity,
                      "slots": slots,
                    },
                  );
                },

                child: const Text("Save Slots"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}