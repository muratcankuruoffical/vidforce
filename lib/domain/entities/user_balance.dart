/// User's credit balance
class UserBalance {
  final int credits;
  final DateTime lastUpdated;

  const UserBalance({
    required this.credits,
    required this.lastUpdated,
  });

  UserBalance copyWith({
    int? credits,
    DateTime? lastUpdated,
  }) {
    return UserBalance(
      credits: credits ?? this.credits,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  bool canAfford(int cost) => credits >= cost;
}
