class IngredientsData {
  final double? quantity;
  final String unit;
  final String descText;

  IngredientsData({
    required this.quantity,
    required this.unit,
    required this.descText,
  });

  factory IngredientsData.fromJson(Map<String, dynamic> json) {
    return IngredientsData(
      quantity: json['quantity']?.toDouble(),
      unit: json['unit'],
      descText: json['description'],
    );
  }
}
