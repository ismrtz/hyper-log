class Transaction {
  final int? id;
  final int amount;
  final int categoryId;
  final int resourceId;
  final String createdAt;
  final String? description;

  Transaction({
    this.id,
    required this.amount,
    required this.categoryId,
    required this.resourceId,
    required this.createdAt,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'resourceId': resourceId,
      'createdAt': createdAt,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Transaction{id: $id, amount: $amount, categoryId: $categoryId, resourceId: $resourceId, createdAt: $createdAt, description: $description}';
  }
}
