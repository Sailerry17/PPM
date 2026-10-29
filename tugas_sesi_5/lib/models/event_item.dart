class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dateLabel,
    required this.time,
    required this.venue,
    required this.description,
    required this.colorValue,
    required this.iconCodePoint,
  });

  final String id;
  final String title;
  final String category;
  final String dateLabel;
  final String time;
  final String venue;
  final String description;
  final int colorValue;
  final int iconCodePoint;
}
