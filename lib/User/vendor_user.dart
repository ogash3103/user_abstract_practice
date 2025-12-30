import 'package:user_abstract_practice/Product/product.dart';
import 'package:user_abstract_practice/User/user.dart';

class VendorUser extends User {
  double _balance;
  final List<Product> _products;

  VendorUser({
    required super.name,
    required super.email,
    required super.password,
    double initialBalance = 0,
    List<Product>? products,
  })  : _balance = initialBalance,
        _products = List<Product>.from(products ?? []) {
    if (_balance < 0) throw ArgumentError('Vendor balance manfiy bo‘lishi mumkin emas.');
  }

  void display(String password) {
    if (!verifyPassword(password)) {
      print('❌ Vendor password xato. Info ko‘rsatilmadi.');
      return;
    }
    print('--- VENDOR INFO ---');
    print('Name: $name');
    print('Email: $email');
    print('Balance: $_balance');
    print('Products:');
    for (final p in _products) {
      print('  - $p');
    }
    print('-------------------');
  }

  // Vendor inventorydan product topish
  int _indexOfProductById(int productId) =>
      _products.indexWhere((p) => p.id == productId);


  Product? toSell({
    required Product product,
    required int amount,
  }) {
    if (amount <= 0) {
      print('❌ [Vendor] amount musbat bo‘lishi kerak.');
      return null;
    }

    final idx = _indexOfProductById(product.id);
    if (idx == -1) {
      print('❌ [Vendor] Product topilmadi: ${product.name} (id=${product.id})');
      return null;
    }

    final inStock = _products[idx];
    if (inStock.quantity < amount) {
      print('❌ [Vendor] Omborda yetarli mahsulot yo‘q. Bor: ${inStock.quantity}, so‘ralgan: $amount');
      return null;
    }

    // Stock kamayadi
    _products[idx] = inStock.copyWith(quantity: inStock.quantity - amount);

    // Agar 0 bo‘lib qolsa, ro‘yxatdan olib tashlash ham mumkin (ixtiyoriy)
    if (_products[idx].quantity == 0) {
      _products.removeAt(idx);
    }

    // Sotilgan product “chek” ko‘rinishida qaytadi (quantity = amount)
    return inStock.copyWith(quantity: amount);
  }

  // Client pul to‘laganda vendor balansi oshadi (internal)
  void receiveMoney(double amount) {
    _balance += amount;
  }
}