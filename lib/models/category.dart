class Category {
  final String name;
  final int id;

  Category({required this.name, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['categoryName'] as String, id: json['id'] as int);
  }
}
