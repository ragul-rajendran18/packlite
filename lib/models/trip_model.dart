class Trip {
  final String title;
  final bool isGroup;

  int packed;
  int total;

  Trip({
    required this.title,
    required this.isGroup,
    this.packed = 0,
    this.total = 0,
  });

  double get progress {
    if (total == 0) return 0;
    return packed / total;
  }
}