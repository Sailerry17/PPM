class RegistrationTicket {
  RegistrationTicket({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.name,
    required this.nim,
    required this.email,
    required this.whatsapp,
    required this.participantType,
    required this.attendanceDate,
    required this.kitPackage,
    required this.donation,
    required this.createdAt,
  });

  final String id;
  final String eventId;
  final String eventTitle;
  final String name;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType;
  final DateTime attendanceDate;
  final String kitPackage;
  final int donation;
  final DateTime createdAt;
}
