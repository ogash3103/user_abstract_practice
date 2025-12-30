import 'package:user_abstract_practice/Product/product.dart';
import 'package:user_abstract_practice/User/client_user.dart';
import 'package:user_abstract_practice/User/vendor_user.dart';

void main() {
  final vendor = VendorUser(
    name: 'BestSeller',
    email: 'vendor@shop.com',
    password: 'vendor1',
    initialBalance: 0,
    products: const [
      Product(id: 1, name: 'iPhone 15', price: 1200, quantity: 3),
      Product(id: 2, name: 'AirPods Pro', price: 250, quantity: 10),
      Product(id: 3, name: 'MacBook', price: 2000, quantity: 1),
    ],
  );

  final client = ClientUser(
    name: 'Ogabek',
    email: 'ogabek@mail.com',
    password: 'client1',
    initialBalance: 1000,
  );

  // 1) Display (xato password)
  client.display('wrong');
  vendor.display('wrong');

  // 2) To‘g‘ri password bilan ko‘rish
  client.display('client1');
  vendor.display('vendor1');

  // 3) Pul yetmaydigan holat (iPhone 15 = 1200, client balance = 1000)
  client.shopping(
    vendor: vendor,
    product: const Product(id: 1, name: 'iPhone 15', price: 1200, quantity: 0),
    amount: 1,
  );

  // 4) Client topUp qilib balansni to‘ldiradi
  client.topUp(password: 'client1', amount: 500);

  // 5) Endi iPhone sotib oladi (muvaffaqiyatli)
  client.shopping(
    vendor: vendor,
    product: const Product(id: 1, name: 'iPhone 15', price: 1200, quantity: 0),
    amount: 1,
  );

  // 6) Vendor stock yetmaydigan holat (MacBook stock 1, 2 so‘raymiz)
  client.shopping(
    vendor: vendor,
    product: const Product(id: 3, name: 'MacBook', price: 2000, quantity: 0),
    amount: 2,
  );

  // 7) AirPods’dan 2 dona sotib oladi
  client.shopping(
    vendor: vendor,
    product: const Product(id: 2, name: 'AirPods Pro', price: 250, quantity: 0),
    amount: 2,
  );

  // 8) Yakuniy holatlarni ko‘ramiz
  client.display('client1');
  vendor.display('vendor1');
}
