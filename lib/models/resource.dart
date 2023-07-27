class Resource {
  final int? id;
  final String title;
  final int type;
  final String icon;
  final String color;
  final String? card;
  final String? account;

  Resource({
    this.id,
    required this.title,
    required this.type,
    required this.icon,
    required this.color,
    this.card,
    this.account,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'icon': icon,
      'color': color,
      'card': card,
      'account': account
    };
  }

  @override
  String toString() {
    return 'Resource{id: $id, title: $title, type: $type, icon: $icon, color: $color, card: $card, account: $account}';
  }
}
