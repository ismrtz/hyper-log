class Category {
  final int? id;
  final String title;
  final int type;
  final String icon;
  final String color;

  Category({
    this.id,
    required this.title,
    required this.type,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'icon': icon,
      'color': color
    };
  }

  @override
  String toString() {
    return 'Category{id: $id, title: $title, type: $type, icon: $icon, color: $color}';
  }
}
