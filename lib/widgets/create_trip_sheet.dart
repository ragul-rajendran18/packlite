import 'package:flutter/material.dart';
import '../models/trip_model.dart';

class CreateTripSheet extends StatefulWidget {
  final Function(Trip) onCreate;

  const CreateTripSheet({super.key, required this.onCreate});

  @override
  State<CreateTripSheet> createState() => _CreateTripSheetState();
}

class _CreateTripSheetState extends State<CreateTripSheet> {
  final TextEditingController controller = TextEditingController();
  bool isPersonal = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text("Create New Trip",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),

          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Trip name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text("Personal"),
                  selected: isPersonal,
                  onSelected: (_) {
                    setState(() => isPersonal = true);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Text("Group"),
                  selected: !isPersonal,
                  onSelected: (_) {
                    setState(() => isPersonal = false);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              final trip = Trip(
                title: controller.text,
                isGroup: !isPersonal,
                packed: 0,
                total: 0,
              );
              widget.onCreate(trip);
              Navigator.pop(context);
            },
            child: const Text("Create Trip"),
          )
        ],
      ),
    );
  }
}