import 'package:flutter/material.dart';

class AddCityScreen extends StatefulWidget {
  final Function(String) onSave;

  const AddCityScreen({super.key, required this.onSave});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(15),

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Add New City",

            style: TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: Colors.blue,
            ),
          ),

        SizedBox(height: 20),

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
                widget.onSave(cityController.text);
              },

              child: const Text("Save City"),
            ),
          ),
        ],
      ),
    );
  }
}