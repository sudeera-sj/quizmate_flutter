/// Represents a quiz category in the API
class Category {
  static const Category defaultCategory = Category(0, 'Any Category');

  final int id;
  final String name;

  const Category(this.id, this.name);

  Category.fromJson(dynamic json)
      : this.id = json["id"] ?? -1,
        this.name = json["name"] ?? '';
}
