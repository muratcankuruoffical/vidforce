/// Credit pack for purchase
class CreditPack {
  final String id;
  final String title;
  final int credits;
  final double price;
  final String currency;
  final bool isBestValue;
  final String? description;
  final double? discount;

  const CreditPack({
    required this.id,
    required this.title,
    required this.credits,
    required this.price,
    this.currency = 'USD',
    this.isBestValue = false,
    this.description,
    this.discount,
  });

  String get formattedPrice => '\$$price';

  double get pricePerCredit => price / credits;

  String get formattedPricePerCredit =>
      '\$${pricePerCredit.toStringAsFixed(2)} per credit';
}
