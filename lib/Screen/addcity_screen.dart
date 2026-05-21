import 'package:flutter/material.dart';

class AddCityScreen extends StatefulWidget {

  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {

  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add City"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            TextField(

              controller: cityController,

              decoration: InputDecoration(

                hintText: "Enter City Name",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                    cityController.text,
                  );
                },

                child: const Text("Save City"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}