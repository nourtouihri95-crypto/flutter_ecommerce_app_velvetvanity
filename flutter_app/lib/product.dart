class Product {
  final String name;
  final String image;
  final double price;
  final String category;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'category': category,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
    );
  }

}

