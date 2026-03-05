class Item {
  final String name;
  final String category;

  bool isSelected;   // catalog select
  bool isPacked;     // suitcase packing

  Item({
    required this.name,
    required this.category,
    this.isSelected = false,
    this.isPacked = false,
  });
}