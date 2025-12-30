import 'package:user_abstract_practice/Product/product.dart';
import 'package:user_abstract_practice/User/user.dart';
import 'package:user_abstract_practice/User/vendor_user.dart';

class ClientUser extends User {
  double _balance;
  final List<Product> _purchasedItems;

  ClientUser({
    required super.name,
    required super.email,
    required super.password,
    double initialBalance = 0,
  })  : _balance = initialBalance,
        _purchasedItems = [] {
    if (_balance < 0) throw ArgumentError('Client balance manfiy bo‘lishi mumkin emas.');
  }

  void display(String password) {
    if (!verifyPassword(password)) {
      print('❌ Client password xato. Info ko‘rsatilmadi.');
      return;
    }
    print('--- CLIENT INFO ---');
    print('Name: $name');
    print('Email: $email');
    print('Balance: $_balance');
    print('Purchased items:');
    if (_purchasedItems.isEmpty) {
      print('  (empty)');
    } else {
      for (final p in _purchasedItems) {
        print('  - $p');
      }
    }
    print('-------------------');
  }

  int _indexOfPurchasedById(int productId) =>
      _purchasedItems.indexWhere((p) => p.id == productId);

  void _addToPurchased(Product bought) {
    final idx = _indexOfPurchasedById(bought.id);
    if (idx == -1) {
      _purchasedItems.add(bought);
    } else {
      final current = _purchasedItems[idx];
      _purchasedItems[idx] = current.copyWith(quantity: current.quantity + bought.quantity);
    }
  }

  // shopping ishlasa, vendor.toSell ishlaydi (ketma-ket: check -> sell -> pay -> sync)
  void shopping({
    required VendorUser vendor,
    required Product product,
    required int amount,
  }) {
    if (amount <= 0) {
      print('❌ [Client] amount musbat bo‘lishi kerak.');
      return;
    }

    final totalCost = product.price * amount;

    // 1) Client pulini tekshiramiz
    if (_balance < totalCost) {
      print('❌ [Client] Pul yetarli emas. Balans: $_balance, kerak: $totalCost');
      return;
    }

    // 2) Vendor tomondan sotish (inventory check + decrement)
    final sold = vendor.toSell(product: product, amount: amount);
    if (sold == null) {
      // Vendor tarafida muammo bo‘lsa: pul yechilmaydi
      print('❌ [Client] Xarid amalga oshmadi (vendor inventory muammo).');
      return;
    }

    // 3) Hammasi OK bo‘lsa: pul yechamiz, vendor’ga o‘tkazamiz
    _balance -= totalCost;
    vendor.receiveMoney(totalCost);

    // 4) Purchased list sync
    _addToPurchased(sold);

    print('✅ Xarid muvaffaqiyatli: ${sold.name} x${sold.quantity} (total: $totalCost)');
    print('   Client new balance: $_balance');
  }

  // (Optional) topUp ham qo‘shib qo‘ydim — realga yaqin bo‘lishi uchun
  void topUp({
    required String password,
    required double amount,
  }) {
    if (!verifyPassword(password)) {
      print('❌ Client password xato. TopUp bekor.');
      return;
    }
    if (amount <= 0) {
      print('❌ TopUp amount musbat bo‘lishi kerak.');
      return;
    }
    _balance += amount;
    print('✅ Client topUp +$amount. New balance: $_balance');
  }
}