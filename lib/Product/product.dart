class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;


  const Product ({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity
}) : assert(price >= 0),
     assert(quantity >= 0);

  double subtotal(int amount) => price * amount;

  Product copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity
    );
  }
  @override
  String toString() => 'Product(id: $id, name: $name, '
                      'price: $price, quantity: $quantity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
  other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode;
}