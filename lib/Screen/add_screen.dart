import 'package:flutter/material.dart';

class AddParkingScreen extends StatefulWidget {

  const AddParkingScreen({super.key});

  @override
  State<AddParkingScreen> createState() => _AddParkingScreenState();
}

class _AddParkingScreenState extends State<AddParkingScreen> {

  TextEditingController cityController = TextEditingController();

  TextEditingController slotController = TextEditingController();

  List<String> slots = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(title: const Text("Add Parking"),),
                   body: Padding(padding: const EdgeInsets.all(15),
                   child: Column(
                    
                  children: [TextField(controller: cityController,
                  decoration: InputDecoration(hintText: "Enter City",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
               ),
               ),

            SizedBox(height: 15),
            Row(

              children: [
              Expanded(

                  child: TextField(
                    controller: slotController,
                    decoration: InputDecoration(hintText: "Enter Slot",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    ),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {

                    if(slotController.text.isNotEmpty) {
                      setState(() {
                        slots.add(slotController.text);

                   });
                      slotController.clear();
                    }
                  },

                  child:Text("Add"),
                ),
              ],
            ),

            const SizedBox(height: 20),

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

            SizedBox(
            width: double.infinity,

            child: ElevatedButton(

            onPressed: () {

          if(cityController.text.isNotEmpty && slots.isNotEmpty) {

              Navigator.pop(context,
              {
                    "city": cityController.text,
                    "slots": slots,
              },
              );
                  }
                },

          child: const Text("Save"),
          ),
        ),
          ],
        ),
  ),
    );
  }
}