class DeliveryDetails {
  final String street;
  final String details;
  final String? note;

  DeliveryDetails({
    required this.street,
    required this.details,
    this.note,
  });


  DeliveryDetails copyWith({
    String? street,
    String? details,
    String? note,
  }) {
    return DeliveryDetails(
      street: street ?? this.street,
      details: details ?? this.details,
      note: note ?? this.note,
    );
  }
}
