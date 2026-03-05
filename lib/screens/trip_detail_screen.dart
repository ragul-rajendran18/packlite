import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../data/dummy_items.dart';
import '../models/item_model.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {

  List<Item> allItems = dummyItems;
  List<Item> selectedItems = [];

  String selectedCategory = "All";

  bool isCatalog = true;
  bool hidePacked = false;

  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "clothes":
        return Icons.checkroom;
      case "electronics":
        return Icons.devices;
      case "toiletries":
        return Icons.brush;
      case "documents":
        return Icons.description;
      case "accessories":
        return Icons.watch;
      default:
        return Icons.luggage;
    }
  }

  @override
  Widget build(BuildContext context) {

    List<String> categories = [
      "All",
      ...allItems.map((e) => e.category).toSet()
    ];

    List<Item> filteredItems = selectedCategory == "All"
        ? allItems
        : allItems.where((item) => item.category == selectedCategory).toList();

    double progress = selectedItems.isEmpty
        ? 0
        : selectedItems.where((e) => e.isPacked).length / selectedItems.length;

    bool allPacked =
        selectedItems.isNotEmpty &&
        selectedItems.every((item) => item.isPacked);

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.trip.title),
        centerTitle: true,
      ),

      body: Column(
        children: [

          const SizedBox(height: 10),

          /// Modern Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCatalog = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isCatalog ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Catalog",
                            style: TextStyle(
                              color: isCatalog ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCatalog = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !isCatalog ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Suitcase",
                            style: TextStyle(
                              color: !isCatalog ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Suitcase Mode
          if (!isCatalog)
            Column(
              children: [

                /// Animated Progress Ring
                TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: progress),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, value, child) {

                    double val = value as double;

                    return SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [

                          SizedBox(
                            height: 120,
                            width: 120,
                            child: CircularProgressIndicator(
                              value: 1,
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation(
                                  Colors.grey.shade300),
                            ),
                          ),

                          SizedBox(
                            height: 120,
                            width: 120,
                            child: CircularProgressIndicator(
                              value: val,
                              strokeWidth: 10,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.blue),
                            ),
                          ),

                          Text(
                            "${(val * 100).toInt()}%",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                SwitchListTile(
                  title: const Text("Hide Packed Items"),
                  value: hidePacked,
                  onChanged: (v) {
                    setState(() {
                      hidePacked = v;
                    });
                  },
                ),

                /// Happy Journey UI
                if (allPacked)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [

                        Text(
                          "🎉 All items packed!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "✈️ Happy Journey!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )

                      ],
                    ),
                  ),

              ],
            ),

          /// Category Chips
          if (isCatalog)
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((cat) {

                  bool selected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

          const SizedBox(height: 10),

          /// Items List
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ListView.builder(

                key: ValueKey(isCatalog),

                itemCount: isCatalog
                    ? filteredItems.length
                    : selectedItems.length,

                itemBuilder: (_, index) {

                  Item item = isCatalog
                      ? filteredItems[index]
                      : selectedItems[index];

                  if (!isCatalog && hidePacked && item.isPacked) {
                    return const SizedBox();
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(

                      leading: Icon(
                        getCategoryIcon(item.category),
                        color: Colors.blue,
                      ),

                      title: Text(
                        item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500),
                      ),

                      subtitle: Text(item.category),

                      trailing: Checkbox(

                        value: isCatalog
                            ? item.isSelected
                            : item.isPacked,

                        onChanged: (val) {

                          setState(() {

                            if (isCatalog) {

                              item.isSelected = val!;

                              if (val) {
                                selectedItems.add(item);
                              } else {
                                selectedItems.remove(item);
                              }

                            } else {

                              item.isPacked = val!;
                            }

                          });

                        },
                      ),

                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}